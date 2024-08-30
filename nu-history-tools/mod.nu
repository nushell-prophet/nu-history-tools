# This Nushell module contains utilities to analyze the usage statistics of Nushell commands based on user history.

# Calculates and aggregates statistics for Nushell command usage across .nu files and command histories.
# It includes features for normalization of data, creation of visual graphs and bars to represent data,
# and benchmarking command usage against submissions from other users.

# https://github.com/nushell-prophet/nu-history-tools

use utils [bar spark normalize cprint 'fill non-exist' ansi-alternate]
use internals.nu [open_submission generate-graphs export-history list-current-commands]

# Calculates statistics for the current user's command history.
export def analyze-history [
    --quiet (-q) # Suppress information messages
    --pick_users    # This flag triggers an interactive user selection to filter benchmarks during script execution
    --nickname: string = 'WriteYourNick' # The nick to use for resulting stats (can be submitted to common stats repo)
]: nothing -> table {
    $env.freq-hist.pick-users = $pick_users
    $env.freq-hist.quiet = $quiet

    if not $quiet {
        cprint --frame '*' --align 'center' --lines_after 2 'nu-commands-frequency-stats v2.1'

        let $compatible_versions = ['0.97.1']
        let $running_version = version | get version

        if $running_version not-in $compatible_versions {
            cprint --lines_after 1 --lines_before 1 $'This script was tested on *($compatible_versions)*. You have *($running_version)*.
                If you have problems running this script, consider upgrading Nushell.'
        }
    }


    let $temp_history_file = $nu.temp-path | path join $'nushell_hist_for_ast(random chars).nu'

    export-history $temp_history_file

    let $res = calculate-commands-frequency-in-nu-file --extra_graphs $temp_history_file

    $res
    | save-stats-for-submission $nickname

    $res
    | generate-benchmarks
    | sort-by freq -r
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

# Calculate stats of commands in given .nu files
# > glob **/*.nu --not ['**/themes/**/' '**/before_v0.60/**' '**/custom-completions/**'] | nu-files-stats
export def nu-files-stats [
    ...file_paths: path
]: [list<path> -> table, nothing -> table] {
    default $file_paths
    | par-each {calculate-commands-frequency-in-nu-file $in}
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
        generate-graphs $ast_data
    } else {}
}

# Parses submitted stats from a folder and aggregates them for benchmarking.
# Can interactively select users to include in the analysis.
export def aggregate-submissions [
    --quiet (-q) # Suppress information messages
    --submissions_path: path = 'stats_submissions'  # A path to a folder that contains submitted results.
    --pick_users                                    # This flag triggers interactive user selection during script execution.
]: nothing -> table {
    if $quiet {
        $env.freq-hist.quiet = true
    }

    if $env.freq-hist?.quiet? != true {
        cprint -f '*' --align 'center' --lines_after 2 -H grey --keep_single_breaks 'Aggregated stats of other users for benchmarks.
            *They will be displayed in the final table*.'
    }

    let $user_selection_dialog = $pick_users or ($env.freq-hist?.pick-users? | default false)

    let $aggregated_submissions = $submissions_path
        | path join *.csv
        | ls $in --full-paths
        | sort-by size -r
        | get name
        | where $it !~ 'WriteYourNick.csv' # default output
        | if $user_selection_dialog {
            each {|i| $i | path relative-to (pwd)} # make paths shorter for 'input list'
            | input list --multi
        } else {}
        | par-each {|filename| open_submission $filename}
        | sort-by command_entries -r

    let $ordered_users = $aggregated_submissions
        | select user command_entries
        | enumerate
        | flatten
        | update user {|i| $'(ansi-alternate $i.index)($i.user)(ansi reset)'}

    if $env.freq-hist?.quiet? != true {
        if not $user_selection_dialog {
            cprint --lines_after 2 '*freq_by_user* (frequency norm by user) includes stats from all users.
                You can pick some of them by providing the *--pick_users* flag: *stats --pick_users* or
                *aggregate-submissions --pick_users*.'
        }

        print $ordered_users
    }

    let $grouped_statistics = $aggregated_submissions
        | select commands user
        | flatten
        | flatten
        | group-by name

    let $user_sparklines = $grouped_statistics
        | values
        | each {|b| {name: $b.name.0, freq_by_user: (spark $b.freq_norm --colors)}}
        | transpose -idr

    let $final_analytics = $grouped_statistics
        | items { |name b|
            {
                name: $name,
                category: $b.category.0,
                freq_overall: ($b.freq | math sum),
                users_count: ($b.freq | where $it > 0 | length),
                f_n_per_user: ($b.freq_norm | math avg),
                freq_by_user: ($user_sparklines | get $name),
            }
        }
        | insert importance {
            |i| $i.users_count * $i.f_n_per_user | math sqrt # geometric mean
        }
        | normalize importance --suffix ''
        | sort-by importance -r
        | insert importance_b {|i| bar $i.importance --width ('importance_b' | str length)}

    $final_analytics
    | join -l (list-all-commands | reject category) name     # here we join table to have info about github tags, when commands were introduced
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

# Provides a list with all commands ever implemented in Nushell and their crates.
# Useful for cross-referencing current commands against historical data.
#
# > use nu-history-tools.nu list-all-commands; let $res = list-all-commands; $res | last 3
# ╭────name─────┬─────crate──────┬first_tag┬last_tag┬──category──╮
# │ unfold      │ nu-command     │ 0.86.0  │ 0.86.0 │ generators │
# │ url decode  │ nu-command     │ 0.86.0  │ 0.86.0 │ strings    │
# │ hash sha256 │ not_parsed_yet │ 0.86.0  │ 0.86.0 │ hash       │
# ╰─────────────┴────────────────┴─────────┴────────┴────────────╯
export def list-all-commands []: nothing -> table {
    let $crate_history = 'crates_parsing'
        | path join 'cmds_by_crates_and_tags.csv'
        | if ($in | path exists) {
            open
        } else {[]}

    let $current_command_list = list-current-commands

    let $ver = version | get version

    # The $default_command_data is used if there is no crates parsing history.
    # You can update the CSV file by running crates_parsing/crates_parsing.nu
    let $default_command_data = $current_command_list
        | select name
        | insert crate not_parsed_yet
        | insert first_tag $ver
        | insert last_tag $ver

    $crate_history
    | append $default_command_data
    | uniq-by name
    | join -l $current_command_list name
}
