# This NuShell module contains utilities to analyze the usage statistics of NuShell commands based on user history.

# Calculates and aggregates statistics for NuShell command usage across .nu files and command histories.
# It includes features for normalization of data, creation of visual graphs and bars to represent data,
# and benchmarking command usage against submissions from other users.

# https://github.com/Nushell101/nu-stats

use nu-utils [bar spark normalize cprint 'fill non-exist' ansi-alternate]

# Calculates statistics for the current user's command history.
export def nu-hist-stats [
    --pick_users    # This flag triggers an interactive user selection to filter benchmarks during script execution.
] {
    $env.freq-hist.pick-users = $pick_users

    cprint --after 2 --frame '*' 'nu-commands-frequency-stats v2.0'

    let $tested_versions = ['0.86.0']
    let $current_version = (version | get version)
    let $temp_file = ($nu.temp-path | path join $'nushell_hist_for_ast(random chars).nu')

    history-save $temp_file

    if $current_version not-in $tested_versions {
        cprint --after 2 $'This script was tested on *($tested_versions)*. You have *($current_version)*.
        If you have problems running this script, consider upgrading NuShell.'
    }

    cprint --before 1 --after 2 'The script is calculating stats now.
    On an M1 Mac with a history of ~50,000 entries, It runs for about a minute. Please wait'

    nu-file-stats --extra_graphs $temp_file
    | reject first_tag last_tag crate
    | upsert '' 'x'     # To separate data from others and current user's data
    | make-benchmarks
}

# Calculate stats of commands in a given .nu files
# > glob **/*.nu --not ['**/themes/**/' '**/before_v0.60/**' '**/custom-completions/**'] | nu-files-stats
export def nu-files-stats [
    ...file_paths: path
] {
    $in
    | default $file_paths
    | par-each {|i| nu-file-stats $i}
    | flatten
    | where freq != null
    | group-by name
    | values
    | par-each {|i| $i | get 0 | upsert freq ($i.freq | math sum)}
    | normalize freq
    | upsert freq_norm_bar {|i| bar $i.freq_norm --width ('freq_norm_bar' | str length)}
    | sort-by freq -r
}

# Calculate stats of command usage in a specified `.nu` file.
# Generates additional graphs and normalizes frequency data upon request.
# Saves the output to a user-defined path.
export def nu-file-stats [
    path: path
    --normalize_freq    # Adds a normalized frequency column to the output.
    --extra_graphs      # Includes frequency histogram and timeline sparklines in the output.
    --submissions_path: path = 'stats_submissions' # Specifies the path to a folder containing submitted results.
] {
    let $ast_data = (
        nu --ide-ast $path --no-config-file --no-std-lib
        | from json
        | where shape in ['shape_internalcall' 'keyword']
    )

    let $freq_table = ($ast_data | get content | uniq --count | rename name freq)

    let $freq_builtins_only = (
        commands-all
        | join $freq_table -l name
        | upsert freq {|i| $i.freq | default 0}
    )

    let $output = (
        $freq_builtins_only
        | if $normalize_freq or $extra_graphs {
            normalize freq
        } else {}
        | if $extra_graphs {
            make_extra_graphs $ast_data
        } else {}
    )

    $output
    | if $extra_graphs {
        select name freq timeline
    } else {
        select name freq
    }
    | save -f (
        $submissions_path
        | path join $'v2_(date now | format date "%Y-%m-%d")+WriteYourNick.csv'
    )

    $output
}

# Parses submitted stats from a folder and aggregates them for benchmarking.
# Can interactively select users to include in the analysis.
export def aggregate-submissions [
    --submissions_path: path = 'stats_submissions'  # A path to a folder that contains submitted results.
    --pick_users                                    # This flag triggers interactive user selection during script execution.
] {
    cprint -f '*' --after 2 -h grey 'Aggregated stats of other users for benchmarks. *Will be displayed in the final table*'

    let $pick_users_dialogue = $pick_users or ($env.freq-hist?.pick-users? | default false)

    let $submissions_stats = (
        ls $submissions_path --full-paths
        | where ($it.name | path parse | get extension) == 'csv'
        | sort-by size -r
        | get name
        | where $it !~ 'WriteYourNick.csv' # default output
        | if $pick_users_dialogue {
            each {|i| $i | path relative-to (pwd)} # make paths shorter for 'input list'
            | input list --multi
        } else {}
        | par-each {
            |filename|
            open $filename
            | if ('command_type' in ($in | columns)) {
                reject command_type
            } else {}
            | if ('freq' in ($in | columns)) { # legacy fix
                rename -c {freq: count}
            } else {}
            | group-by name
            | do {
                |dict|
                commands-all
                | upsert count {
                    |i| $dict | get -i $i.name | get -i count.0 | default 0
                }
                | normalize count
                | upsert count_norm_bar {|i| bar $i.count_norm -w ('count_norm_bar' | str length)}
            } $in
            | {commands: $in}
            | upsert user ($filename | path basename | str replace -r '(.*)\+(.*)\.csv' '$2')
            | upsert command_entries {|i| $i.commands.count | math sum} # The total count of command entries in history of current user
        }
        | sort-by command_entries -r
    )

    let $users_ordered = (
        $submissions_stats
        | select user command_entries
        | enumerate
        | flatten
        | upsert user {|i| $'(ansi-alternate $i.index)($i.user)(ansi reset)'}
    )

    if not $pick_users_dialogue {
        cprint --after 2 '*freq_by_user* (frequency norm by user) includes stats from all users.
        You can pick some of them by providing the *--pick_users* flag: *nu-hist-stats --pick_users* or
        *aggregate-submissions --pick_users*.'
    }

    print $users_ordered

    let $stat_grouped = (
        $submissions_stats
        | select commands user
        | flatten
        | flatten
        | group-by name
    )

    let $3_sparklines = (
        $stat_grouped
        | values
        | each {|b| {name: $b.name.0, freq_by_user: (spark $b.count_norm --colors)}}
        | transpose -idr
    )

    let $fin_analytics = (
        $stat_grouped
        | items {
            |name b| {
                name: $name,
                category: $b.category.0,
                freq_overall: ($b.count | math sum),
                users_count: ($b.count | where $it > 0 | length),
                f_n_per_user: ($b.count_norm | math avg),
                freq_by_user: ($3_sparklines | get $name),
            }
        }
        | upsert importance {
            |i| ($i.users_count * $i.f_n_per_user) | math sqrt # geometric mean
        }
        | normalize importance --suffix ''
        | sort-by importance -r
        | upsert importance_b {|i| bar $i.importance --width ('importance_b' | str length)}
    );

    $fin_analytics
    | join -l (commands-all | reject category) name     # here we join table to have info about github tags, when commands was introduced
}

# Create benchmark columns for piped-in stats.
# Adds extra columns to the data for visual representation and calculation of importance.
export def make-benchmarks [] {
    let $data = $in

    let $benchmarks = (
        aggregate-submissions
        | select name importance importance_b freq_by_user
    );

    cprint -f '*' 'Resulting table'

    cprint --keep_single_breaks --after 2 '*A note about some columns*:
    - *freq* - indicates the overall frequency of use of the given command for the currently analyzed source
    - *freq_norm* - represents the overall frequency normalized
    - *freq_norm_bar* - shows the overall frequency normalized in a bar chart format
    - *timeline* - displays the dynamics, indicating when the command was used throughout your history
    - *importance* - calculated as the geometric mean of the number of users who used this command and the average normalized frequency
    - *freq_by_user* (frequency norm by user) - each bar in the sparkline column represents one user (order is shown in the table above).'

    $data
    | join -l $benchmarks name
    | upsert importance {|i| $i | get -i importance | default 0}
    | sort-by importance -r -n
    | fill non-exist ''
}

# Provides a list with all commands ever implemented in NuShell and their crates.
# Useful for cross-referencing current commands against historical data.
export def commands-all [] {
    let $crates_hist = (open crates_parsing/cmds_by_crates_and_tags.csv)

    let $current_commands = (
        help commands
        | select name category command_type
        | where command_type in ['builtin' 'keyword']
        | reject command_type
    )

    let $ver = (version | get version)

    # The $fallback is used if there is no crates parsing history.
    # You can update the CSV file by running crates_parsing/crates_parsing.nu
    let $fallback = (
        $current_commands
        | select name
        | upsert crate not_parsed_yet
        | upsert first_tag $ver
        | upsert last_tag $ver
    )

    $crates_hist
    | append $fallback
    | uniq-by name
    | join -l $current_commands name
}

# Creates extra graphical representations for command usage over time.
# Serves as a helper function within the script for visual data analysis.
def make_extra_graphs [
    $ast_data
] {
    let $table_in = $in
    let $hist_for_timeline = (
        $ast_data
        | upsert start {|i| $i.span.start}
        | select content start
        | upsert start {|i| $i.start // 100_000}
        | uniq --count
        | flatten
    );

    let $def_bins = (
        $hist_for_timeline
        | get start
        | uniq
        | sort
        | reduce -f {} {|a b| $b | merge {$a: 0}}
    )

    let $sparks = (
        $hist_for_timeline
        | group-by content
        | items {
            |a b|
            {
                $a: (
                    $def_bins
                    | merge ($b | select start count | transpose -idr)
                    | values
                    | spark $in
                )
            }
        }
        | reduce -f {} {|a b| $a | merge $b}
    )

    $table_in
    | upsert 'freq_norm_bar' {|i| bar $i.freq_norm --width 10}
    | upsert timeline {
        |i| $sparks
        | get -i $i.name
    }
}

# Combine all history and save it as a `.nu` file to the specified destination.
# Saves history from sql and txt files as a `.nu` file to the specified destination.
def history-save [
    destination_path: path
] {
    let $history_txt_path = ($nu.history-path | str replace sqlite3 'txt')

    mut history_txt = []

    if (($env.config.history.file_format == 'sqlite') and ($history_txt_path | path exists)) {

        cprint --after 2 $'Your history is in *sqlite* format and will be used for analysis.
        Additionally, you have history in *txt* format, which consists of *($history_txt_path | open | lines | length)
        entries*. Would you like to include them in the analysis as well?

        mut answer = ''

        while ($answer | str downcase) not in [y, n] {
            $answer = (input '[y/n]: ')
        }

        $history_txt = (
            if ($answer | str downcase) != 'y' {
                open $history_txt_path | lines
            }
        )
    }

    history
    | get command
    | prepend $history_txt
    | str join $';(char nl)'
    | save -f $destination_path
}
