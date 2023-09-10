# This script calculates aggregated stats
use v2-nu-commands-freq.nu [normalize bar spark]

let $color_set = [white, grey, cyan]

let $0_commands_all = (
    help commands
    | select name category command_type
    | rename command
    | where command_type in ['builtin' 'keyword']
    | reject command_type
);

let $0_stat = (
    ls v1_results_submissions/*.csv --full-paths
    | sort-by size -r
    | get name
    | each {|i| $i | path relative-to (pwd)}
    | input list --multi
    | par-each {
        |filename| open $filename
        | reject command_type
        | rename command # legacy fixing
        | group-by command
        | do {
            |dict|
            $0_commands_all
            | upsert count {
                |i| $dict | get -i $i.command | get -i count.0 | default 0
            }
            | normalize count
            | upsert count_norm_bar {|i| bar $i.count_norm -w ('count_norm_bar' | str length)}
        } $in
        | {commands: $in}
        | upsert user ($filename | path basename | str replace -r '(.*)\+(.*)\.csv' '$2')
        | upsert executions_total {|i| $i.commands.count | math sum}
    }
    | sort-by executions_total -r
)

let $1_users_ordered = (
    $0_stat
    | select user executions_total
    | enumerate
    | flatten
    | upsert user {|i| $'(ansi ($color_set | get ($i.index mod ($color_set | length))))($i.user)'}
)

print $'(ansi green)Users sparkline is ordered by sum of executed commands:(ansi reset)'
print $1_users_ordered

let $2_stat = (
    $0_stat
    | select commands user
    | flatten
    | flatten
)

let $3_sparklines = (
    $2_stat
    | group-by command
    | values
    | each {|b| {command: $b.command.0, users_sparkline: (spark $b.count_norm --colors --color_set $color_set)}}
    | transpose -idr
)

let $4_analytics = (
    $2_stat
    | where count > 0
    | group-by command
    | items {
        |command b| {
            command: $command,
            category: $b.category.0,
            users_count: ($b | length),
            users_freq_norm_avg: ($b.count_norm | math avg),
            users_sparkline: ($3_sparklines | get $command),
        }
    }
    | upsert users_c_rank {
        |i| ($i.users_count * $i.users_freq_norm_avg) | math sqrt # geometric mean
    }
    | normalize users_c_rank --suffix ''
    | sort-by users_c_rank -r
    | upsert users_c_rank_bar {|i| bar $i.users_c_rank --width ('users_c_rank_bar' | str length)}
);

$4_analytics

