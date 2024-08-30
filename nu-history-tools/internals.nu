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

# Insert the command usage timeline sparkline
export def insert-timeline [
    $ast_data
    --number_of_bins: int = 10
]: table -> table {
    let $input = $in

    let $chunks = ($ast_data | last | get span.end)
        | $in - ($ast_data | first | get span.start)
        | $in // $number_of_bins
        | append 30_000
        | math max

    let $hist_for_timeline = $ast_data
        | insert start {|i| $i.span.start // $chunks}
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

export def list-current-commands [] {
    help commands
    | select name category command_type
    | where command_type in ['built-in' 'keyword' 'plugin']
    | reject command_type
}

export def save-stats-for-submission [
    nickname: string
]: table -> nothing {
    let $input = $in

    let $submissions_path = pwd | path join 'stats_submissions'   # if this script is executed from the git folder of nu-history-tools module, there should be a 'submissions' folder
        | if ($in | path exists) { } else {
            error make {msg: `Please run this script for the root of it's git repositor folder`}
        }
        | path join $'v2+($nickname).csv'

    $input
    | select -i name freq
    | sort-by name
    | save -f $submissions_path

    if $env.freq-hist?.quiet? != true {
        cprint --lines_after 2 $'Your stats have been saved to *($submissions_path)*. Please consider donating them
            to the original repository *https://github.com/nushell-prophet/nu-history-tools/tree/main/stats_submissions*.'
    }
}


# Calculate stats of command usage in a specified `.nu` file.
# Generates additional graphs and normalizes frequency data upon request.
# Saves the output to a user-defined path for contributing results to the `nu-history-tools` repo.
export def calculate-commands-frequency-in-nu-file [
    path: path
    --normalize_freq            # Adds a normalized frequency column to the output.
    --extra_graphs              # Includes frequency histogram and timeline sparklines in the output.
    --include_0_freq_commands   # Include all the historical Nushell commands
]: nothing -> table {
    let $ast_data = nu --ide-ast $path --no-config-file --no-std-lib
        | from json
        | where shape in ['shape_internalcall' 'keyword' 'shape_external']

    let $freq_table = $ast_data | get content | uniq --count | rename name freq

    let $freq_builtins_only = list-current-commands
        | join $freq_table -l name # but left join we make sure that only standard commands are included into results
        | if $include_0_freq_commands {
            default 0 freq
        } else {
            where freq? != null
        }

    $freq_builtins_only
    | if $normalize_freq or $extra_graphs {
        normalize freq
    } else {}
    | if $extra_graphs {
        insert 'freq_norm_bar' {|i| bar $i.freq_norm --width 10}
        | insert-timeline $ast_data
    } else {}
}

# Create benchmark columns for piped-in stats.
# Adds extra columns to the data for visual representation and calculation of importance.
export def generate-benchmarks []: table -> table {
    let $input = $in

    let $benchmarks = aggregate-submissions
        | select name importance importance_b freq_by_user

    if $env.freq-hist?.quiet? != true {
        cprint -f '*' --align 'center' 'Resulting table'

        cprint --keep_single_breaks --lines_after 2 '*A note about some columns*:
        - *freq* - indicates the overall frequency of use of the given command for the currently analyzed source
        - *freq_norm* - represents the overall frequency normalized
        - *freq_norm_bar* - shows the overall frequency normalized in a bar chart format
        - *timeline* - displays the dynamics, indicating when the command was used throughout your history
        - *importance* - calculated as the geometric mean of the number of users who used this command and the average normalized frequency
        - *freq_by_user* (frequency norm by user) - each bar in the sparkline column represents one user (order is shown in the table above).'
    }

    $input
    | join -l $benchmarks name
    | default 0 importance
    | sort-by importance -r -n
    | fill non-exist ''
}
