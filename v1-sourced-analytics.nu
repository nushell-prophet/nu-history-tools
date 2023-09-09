# This script calculates aggregated stats
source v2-nu-commands-freq.nu

let $0_commands_all = (
    help commands
    | select name category command_type
    | where command_type in ['builtin' 'keyword']
    | reject command_type
);

let $1_long_stat_with_username = (
    glob v1_results_submissions/*.csv
    | each {
        |i| $i
        | open
        | get count
        | math sum
        | {name: $i, count_sum: $in}}
        | sort-by count_sum -r # here I sort users by total number of commands execution, but in output table only builtin commands
        | get name
        | each {
            |i| $0_commands_all
            | each {
                |b| $b
                | merge (open $i | reject command_type | group-by name | get -i $b.name | get -i 0 | default {count: 0})
            }
            | normalize count
            | upsert count_norm_bar {|i| bar $i.count_norm -w 14}
            | upsert user ($i | path basename | str replace -r '(.*)\+(.*)\.csv' '$2')
        }
        | flatten
);

print $'(ansi green)Users sparkline is ordered by sum of executed commands:(ansi reset)'
print ($1_long_stat_with_username | group-by user | values | each {|i| {user: $i.user.0 count: ($i.count | math sum)}})

let $2_sparklines = (
    $1_long_stat_with_username
    | group-by name
    | values
    | each {|b| {command: $b.name.0, users_sparkline: (spark $b.count_norm)}}
    | transpose -idr
)

let $3_analytics = (
    $1_long_stat_with_username
    | where count > 0
    | group-by name
    | items {
        |a b| {
            command: $a,
            category: $b.category.0,
            users_count: ($b | length),
            freq_norm_avg: ($b.count_norm | math avg),
            users_sparkline: ($2_sparklines | get $a),
        }
    }
    | sort-by freq_norm_avg -r
    | upsert freq_norm_avg_bar {|i| bar $i.freq_norm_avg --width 14}
);

$3_analytics

