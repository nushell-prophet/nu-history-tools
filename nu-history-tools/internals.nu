use utils [bar spark normalize cprint 'fill non-exist']


# Helper function to open a submission file and shape the data for further needs
export def open_submission [
    filename: path
]: nothing -> record {
    open $filename
    | if ('command_type' in ($in | columns)) {
        reject command_type
    } else {}
    | join (list-all-commands) --right name
    | default 0 freq
    | normalize freq
    | insert freq_norm_bar {|i| bar $i.freq_norm -w ('freq_norm_bar' | str length)}
    | {commands: $in}
    | insert user ($filename | path basename | str replace -r '.*\+(.*)\.csv' '$1')
    | insert command_entries {|i| $i.commands.freq | math sum} # The total count of command entries in history of the current user
}

# Creates extra graphical representations for command usage over time.
# Serves as a helper function within the script for visual data analysis.
export def generate-graphs [
    $ast_data
]: table -> table {
    let $input = $in
    let $hist_for_timeline = $ast_data
        | insert start {|i| $i.span.start // 100_000}
        | select content start
        | uniq --count
        | flatten

    let $default_bins = $hist_for_timeline
        | get start
        | uniq
        | sort
        | reduce -f {} {|a| merge {$a: 0}}

    let $sparkline_data = $hist_for_timeline
        | group-by content
        | items {|a b|
            $default_bins
            | merge ($b | select start count | transpose -idr)
            | values
            | spark $in
            | { $a: $in }
        }
        | reduce -f {} {|a b| $a | merge $b}

    $input
    | insert 'freq_norm_bar' {|i| bar $i.freq_norm --width 10}
    | insert timeline {
        |i| $sparkline_data
        | get -i $i.name
    }
}

# Combine history from sql and txt files and save it as a `.nu` file to the specified destination.
export def export-history [
    destination_path: path
]: nothing -> nothing {
    let $history_txt_path = $nu.history-path | str replace 'sqlite3' 'txt'

    mut history_txt = []

    let $use_sqlite = $env.config.history.file_format == 'sqlite'

    if $use_sqlite and ($history_txt_path | path exists) {
        if $env.freq-hist?.quiet? != true {
            cprint --lines_after 2 $'Your history is in *sqlite* format and will be used for analysis.
                Additionally, you have history in *txt* format, which consists of *($history_txt_path | open | lines | length)
                lines*. It will be used for analysis as well.'
        }

        $history_txt = ( open $history_txt_path | lines )
    }

    if $use_sqlite {
        history
        | where exit_status == 0
    } else {
        history
    }
    | get command
    | prepend $history_txt
    | str join $';(char nl)'
    | save -f $destination_path
}
