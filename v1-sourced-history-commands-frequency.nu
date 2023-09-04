# Frequently used Nu commands
def history-stats2 [
    --hours_in_group: int = 4     # When used sql history storage, commands are grouped by number of hours to reduce outliers
    --summary: int = 15
] {
    print "This script calculate will calculate your most frequent Nushell commands"

    let script_start_time = (date now)
    def hist_from_sql [
        hours_in_group
    ] {
        print "You use SQLite as a history storage, so timestamps for your commands are available."
        print $"To reduce outliers, your commands are grouped in chucnks by ($hours_in_group) hours."
        print "If some command was used many times per group in final stats it will be counted only once."
        print "You can change the number of hours in a group by setting a parameter '--hours_in_group'."
        print ""

        (
            $nu.history-path # I've choosen opening sql file directly as it doesn't need converting timestamps (versus 'history' command)
            | open
            | get history
            | where exit_status == 0
            | select start_timestamp command_line
            | upsert rounded_timestamp {
                |it| $it.start_timestamp // (60 * 60 * $hours_in_group)
            } | select rounded_timestamp command_line
            | group-by rounded_timestamp
            | values
            | each {
                |i| $i
                | get command_line
                | str join " "
            }
        )
    }

    def hist_from_txt [] {
        history | get command
    }

    let history_storage = ($nu.history-path | path parse | get extension)

    let hist = (
        if ($history_storage == sqlite3) {
            (hist_from_sql $hours_in_group)
        } else {
            (hist_from_txt)
        }
    )

    let freq = (
        help commands
        | select name command_type
        | par-each {
            |i| $i
            | upsert count_with_subcommands {
                |b| $hist
                | find -r $'\b($i.name)\b'
                | length
            }
        } | where count_with_subcommands > 0
        | sort-by count_with_subcommands -r
    )

    let freq_no_subcommands = (
        $freq
        | par-each {
            |i| $i
            | upsert count {
                |it| $freq
                | where name =~ $'\b($i.name)\b'
                | get count_with_subcommands
                | math sum
                | ($i.count_with_subcommands * 2) - $in
            }
        } | sort-by count -r
        | reject count_with_subcommands
        | where count >= 10
    )

    let total_cmds = (history | length)
    let unique_cmds = (history | get command | uniq | length)

    print $"(ansi green)Total commands in history:(ansi reset) ($total_cmds)"
    print $"(ansi green)Unique commands:(ansi reset) ($unique_cmds)"
    print ""
    print $"(ansi green)Top ($summary)(ansi reset) most used commands:"

    print ($freq_no_subcommands | first $summary)

    let running_time = ((date now) - $script_start_time)


    print 'What types of commands should be included in the CSV file report?'
    print '  1. All'
    print '  2. Built-ins only'
    let include_all = (input 'enter the digit of the option you selected: ')
    print ''

    print 'What is your github nick? It will be used in the name of file.'
    let nick = (input 'Nickname: ')
    print ''

    let filename = $"nu-commands-frequency-($history_storage)+($nick)"

    let out = if $include_all == '1' {
        $freq_no_subcommands
    } else {
        $freq_no_subcommands
        | filter {|i| ($i.command_type == 'builtin') or ($i.command_type == 'keyword')}
    }

    $out | save -f $"($filename).csv"

    let sys_info = (
        sys
        | select host.long_os_version cpu.0.brand mem
        | upsert storage $history_storage
        | upsert nu_version (nu -v)
        | upsert script_duration $running_time
        | upsert total_commands $total_cmds
        | upsert unique_commands $unique_cmds
        | move total_commands unique_commands script_duration --before host_long_os_version
    )

    print ""
    print "Here is some technical information to enrich your report."
    print $"It has been saved to '($filename).txt'"
    print $sys_info

    $sys_info | to yaml | save -f $"($filename).txt" # Github does not allow uploading YAML files to comments.

    print ""
    print $"Files '($filename).csv' and '($filename).txt' have been written."
    print "Kindly share them in the thread: "
    print "https://github.com/nushell/nushell.github.io/issues/899"
}

history-stats2