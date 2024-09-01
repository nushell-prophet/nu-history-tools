# Utilities to analyze the usage statistics of Nushell commands (based on user history or `.nu` files).
# It includes features for the creation of visual graphs and bars to represent data,
# as well as benchmarking command usage against submissions from other users.

# https://github.com/nushell-prophet/nu-history-tools

use utils [bar spark normalize cprint ansi-alternate]
use internals.nu [open_submission export-history list-current-commands save-stats-for-submission
    calculate-commands-frequency-in-nu-file generate-benchmarks]

export use internals.nu aggregate-submissions # generate-benchmarks uses aggregate-submissions, so I put it into internals

# Calculate statistics for the current user's command history. Prepare a file for submission to common stats.
export def analyze-history [
    --quiet (-q) # Suppress information messages
    --pick_users # This flag triggers an interactive user selection to filter benchmarks during script execution
    --nickname: string = 'WriteYourNick' # The nick to use for resulting stats (can be submitted to common stats repo)
]: nothing -> table {
    $env.freq-hist.pick-users = $pick_users
    $env.freq-hist.quiet = $quiet

    if not $quiet {
        cprint --frame '*' --align 'center' --lines_after 2 'nu-commands-frequency-stats v0.2.1'

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

# Calculate stats of commands in given .nu files
# > glob **/*.nu --not ['**/themes/**/' '**/before_v0.60/**' '**/custom-completions/**'] | analyze-nu-files
export def analyze-nu-files [
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
    let $crate_history = 'assets'
        | path join 'crates_parsing' 'cmds_by_crates_and_tags.csv'
        | if ($in | path exists) {
            open
        } else {
            cprint 'To obtain data about the version and when commands were introduced,
                execute this command from the root of the module directory.'
            []
        }

    let $current_command_list = list-current-commands

    let $ver = version | get version

    # The $default_command_data is used if there is no crates parsing history.
    # You can update the CSV file by running crates_parsing/crates_parsing.nu
    let $default_command_data = $current_command_list
        | select name
        | insert crate local_nu_environment
        | insert first_tag $ver
        | insert last_tag $ver

    $crate_history
    | append $default_command_data
    | uniq-by name
    | join -l $current_command_list name
}
