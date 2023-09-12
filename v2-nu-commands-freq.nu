# Calculate frequencies of use of the "nu" commands in a history

export def nu-hist-stats [
    --pick_users    # the flag invokes interactive users selection (during script running) for filtering benchmarks
] {

    cprint 'The script is working with your history now. On an M1 Mac with a history of ~40,000 entries, it runs for about a minute.'

    let $temp_file = ($nu.temp-path | path join $'nushell_hist_for_ast(random chars).nu')
    history | get command | str join $';(char nl)' | save $temp_file -f

    let $result = (
        nu-commands-stats $temp_file --extra_graphs
        | if $pick_users {
            make-benchmarks --pick_users
        } else {
            make-benchmarks
        }
    )

    $result
}

# Calculate frequencies of use of the "nu" commands in a given .nu files
# glob **/*.nu --not ['**/themes/**/' '**/before_v0.60/**' '**/custom-completions/**'] | nu-files-stats $in
export def nu-files-stats [
    ...file_paths: path
] {
    $in
    | default $file_paths
    | par-each {|i| nu-commands-stats $i}
    | flatten
    | where freq != null
    | group-by name
    | values
    | par-each {|i| $i | get 0 | upsert freq ($i.freq | math sum)}
    | normalize freq
    | upsert freq_norm_bar {|i| bar $i.freq_norm --width ('freq_norm_bar' | str length)}
    | sort-by freq -r
}


export def nu-commands-stats [
    path: path
    --normalize_freq    # create a normalized freqency column
    --extra_graphs      # produce frequency histogram and timeline sparklines columns
] {
    let $parsed_hist = (
        nu --ide-ast $path --no-config-file --no-std-lib
        | from json
        | where shape in ['shape_internalcall' 'keyword']
    )

    let $freq_record = ($parsed_hist | get content | uniq --count | transpose -idr)

    let $freq_builtins_only = (
        help commands
        | select name category command_type
        | where command_type in ['builtin' 'keyword']
        | reject command_type
        | upsert freq {
            |i| $freq_record
            | get -i $i.name
            | if $in == [] {
                null
            } else {}
        }
        | upsert freq {|i| if $i.freq == null {0} else {$i.freq}}
    )

    def make_extra_graphs [] {
        let $table_in = $in
        let $hist_with_groups = (
            $parsed_hist
            | upsert start {|i| $i.span.start}
            | select content start
            | upsert start {|i| $i.start // 100_000}
            | uniq --count
            | flatten
        );

        let $def_bins = ($hist_with_groups | get start | uniq | sort | reduce -f {} {|a b| $b | merge {$a: 0}})

        let $sparks = (
            $hist_with_groups
            | group-by content
            | items { |a b| {
                $a: ($def_bins
                    | merge ($b | select start count | transpose -idr)
                    | values
                    | spark $in)
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

    let $output = (
        $freq_builtins_only
        | if $normalize_freq or $extra_graphs {
            normalize freq
        } else {}
        | if $extra_graphs {
            make_extra_graphs
        } else {}
    )

    $output
    | if $extra_graphs {
        select name freq timeline
    } else {
        select name freq
    }
    | save -f (
        'results_submissions'
        | path join $'v2_(date now | format date "%Y-%m-%d")+WriteYourNick.csv'
    )

    $output
}

# parse submitted stats from a folder
export def aggregate-submissions [
    --pick_users    # the flag invokes interactive users selection (during script running)
] {

    let $0_commands_all = (
        help commands
        | select name category command_type
        | rename name
        | where command_type in ['builtin' 'keyword']
        | reject command_type
    );

    let $0_stat = (
        ls results_submissions --full-paths
        | where ($it.name | path parse | get extension) == 'csv'
        | sort-by size -r
        | get name
        | where $it !~ 'WriteYourNick.csv' # default output
        | if $pick_users {
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
                rename -c [freq count]
            } else {}
            | group-by name
            | do {
                |dict|
                $0_commands_all
                | upsert count {
                    |i| $dict | get -i $i.name | get -i count.0 | default 0
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
        | upsert user {|i| $'(ansi-code $i.index)($i.user)(ansi reset)'}
    )

    cprint --keep_single_breaks '
    *f_n_by_user* (frequency norm by user) includes stats from all users.
    You can pick some of them by providing the --pick_users flag: *nu-hist-stats --pick_users* or
    *aggregate-submissions --pick_users*. The current list is:'
    print $1_users_ordered

    let $2_stat = (
        $0_stat
        | select commands user
        | flatten
        | flatten
    )

    let $3_sparklines = (
        $2_stat
        | group-by name
        | values
        | each {|b| {name: $b.name.0, f_n_by_user: (spark $b.count_norm --colors)}}
        | transpose -idr
    )

    let $4_analytics = (
        $2_stat
        | where count > 0
        | group-by name
        | items {
            |name b| {
                name: $name,
                category: $b.category.0,
                freq_overall: ($b.count | math sum),
                users_count: ($b | length),
                f_n_per_user: ($b.count_norm | math avg),
                f_n_by_user: ($3_sparklines | get $name),
            }
        }
        | upsert importance {
            |i| ($i.users_count * $i.f_n_per_user) | math sqrt # geometric mean
        }
        | normalize importance --suffix ''
        | sort-by importance -r
        | upsert importance_b {|i| bar $i.importance --width ('importance_b' | str length)}
    );

    cprint '*importance* is the normalized geometric mean of *users_count* and *f_n_per_user*.'

    $4_analytics
}

export def make-benchmarks [
    --pick_users
] {
    let $data = $in


    let $benchmarks = (
        if $pick_users {
            aggregate-submissions --pick_users
        } else {
            aggregate-submissions
        }
        | select name importance importance_b f_n_by_user
        | group-by name
    );

    cprint --keep_single_breaks '
    *A note about some columns*:
    - *freq* - overall frequency of use of the given command for the currently analysed source,
    - *freq_norm* - overall frequency normalized,
    - *freq_norm_bar* - overall frequency normalized bar,
    - *timeline* - represents dynamics, showing when the command was used throughout your history
    - *importance* - is the geometric mean of the number of users who used this command and average_norm_frequency
    - *f_n_by_user* (frequency norm by user) - each bar in the sparkline column represents 1 user (order is shown in the table above).'

    $data
    | each {|i| $i | merge ($benchmarks | get $i.name -i | get 0 -i | default {'importance': 0})}
    | sort-by importance -r -n
    | fill non-exist ''
}


# construct bars based of a given percentage from a given width (5 is default)
# https://github.com/nushell/nu_scripts/blob/main/sourced/progress_bar/bar.nu
# > bar 0.2
# █
# > bar 0.71
# ███▌
def bar [
    percentage: float
    --background (-b): string = 'default'
    --foreground (-f): string = 'default'
    --progress (-p) # output the result using 'print -n'
    --width (-w): int = 5
] {
    let blocks = [null "▏" "▎" "▍" "▌" "▋" "▊" "▉" "█"]
    let $whole_part = (($blocks | last) * ($percentage * $width // 1))
    let $fraction = (
        $blocks
        | get (
            ($percentage * $width) mod 1
            | $in * ($blocks | length | $in - 1)
            | math round
        )
    )

    let result = (
        $"($whole_part)($fraction)"
        | fill -c $' ' -w $width
        | if ($foreground == 'default') and ($background == 'default') {} else {
            $"(ansi -e {fg: ($foreground), bg: ($background)})($in)(ansi reset)"
        }
    )

    if $progress {
        print -n $"($result)\r"
    } else {
        $result
    }
}

# send an array into spark and get a sparkline out
# https://github.com/nushell/nu_scripts/blob/main/sourced/fun/spark.nu
# let v = [2, 250, 670, 890, 2, 430, 11, 908, 123, 57]
# > spark $v
# ▁▂▆▇▁▄▁█▁▁

# create a small sparkline graph
def spark [
    v: list
    --colors
    --color_set = [white, grey, cyan]
] {
    let TICKS = [(char -u "2581")
              (char -u "2582")
              (char -u "2583")
              (char -u "2584")
              (char -u "2585")
              (char -u "2586")
              (char -u "2587")
              (char -u "2588")]

    let min = ($v | math min)
    let max = ($v | math max)
    let ratio = (if $max == $min { 1.0 } else { 7.0 / ($max - $min)})
    $v | each { |e|
        let i = ((($e - $min) * $ratio) | math round)
        $"($TICKS | get $i)"
    }
    | if $colors {
        enumerate
        | each {|i| $'(ansi-code $i.index)($i.item)(ansi reset)'}
    } else {}
    | str join
}

# normalize values in given columns
# > [[a b]; [1 2] [3 4] [a null]] | normalize a b
# ┏━━━┳━━━┳━━━━━━━━┳━━━━━━━━┓
# ┃ a ┃ b ┃ a_norm ┃ b_norm ┃
# ┣━━━╋━━━╋━━━━━━━━╋━━━━━━━━┫
# ┃ 1 ┃ 2 ┃   0.33 ┃   0.50 ┃
# ┃ 3 ┃ 4 ┃      1 ┃      1 ┃
# ┃ a ┃   ┃        ┃        ┃
# ┗━━━┻━━━┻━━━━━━━━┻━━━━━━━━┛
def normalize [
    ...column_names
    --suffix = '_norm'
] {
    mut $table = $in

    for $column in $column_names {
        let $max_value = (
            $table
            | get $column
            | where ($it | describe | $in in ['int' 'float'])
            | math max
        )

        $table = (
            $table
            | upsert $'($column)($suffix)' {
                |i| $i
                | get $column
                | if ($in | describe | $in in ['int' 'float']) {
                    $in / $max_value
                } else {}
            }
        )
    }

    $table
}

# Print string colourfully
def cprint [
    ...text_args
    --color (-c): any = 'default'
    --highlight_color (-h): any = 'green_bold'
    --frame_color (-r): any = 'dark_gray'
    --frame (-f): string = ' '  # A symbol (or a string) to frame text
    --before (-b): int = 0      # A number of new lines before text
    --after (-a): int = 1       # A number of new lines after text
    --echo (-e)                 # Echo text string instead of printing
    --keep_single_breaks
    --width (-w): int = 80     # The width of text
] {
    let $width_safe = (
        term size
        | get columns
        | ($in / ($frame | str length) | math round)
        | $in - 1
        | [$in $width] | math min
        | [$in 1] | math max    # term size gives 0 in tests
    )

    def compactit [] {
        $in
        | if $keep_single_breaks {
            str replace -r -a '^[\t ]+' ''
        } else {
            str replace -r -a '(\n[\t ]*(\n[\t ]*)+)' '⏎'
            | str replace -r -a '\n?[\t ]+' ' '    # remove single line breaks used for code formatting
            | str replace -a '⏎' "\n\n"
        }
        | lines
        | each {|i| $i | str trim}
        | str join "\n"
    }

    def colorit [] {
        let text = ($in | split chars)
        mut agg = []
        mut open_tag = true
        mut line_length = 0
        mut last_space_index = -1
        mut total_length = 0

        for i in $text {
            if $i == '*' {
                $total_length = $total_length + 1
                if $open_tag {
                    $open_tag = false
                    $agg = ($agg | append $'(ansi reset)(ansi $highlight_color)')
                } else {
                    $open_tag = true
                    $agg = ($agg | append $'(ansi reset)(ansi $color)')
                }
            } else {
                if $i == "\n" {
                    $line_length = 0
                    $last_space_index = -1
                } else {
                    $line_length = ($line_length + 1)
                    if $line_length > $width_safe {
                        if $last_space_index != -1 {
                            $agg = ($agg | update $last_space_index "\n")
                            $line_length = $total_length - $last_space_index
                            $last_space_index = -1
                        } else {
                            $agg = ($agg | append "\n")
                            $line_length = 0
                        }
                    }
                }
                if $i == ' ' {
                    $last_space_index = $total_length
                }
                $agg = ($agg | append $i)
                $total_length = ($total_length + 1)
            }
        }

        $agg
        | str join ''
        | $'(ansi $color)($in)(ansi reset)'
    }

    def frameit [] {
        let $text = $in;
        let $line = (
            ' '
            | fill -a r -w $width_safe -c $frame
            | $'(ansi $frame_color)($in)(ansi reset)'
        )

        (
            $line + "\n" + $text + "\n" + $line
        )
    }

    def newlineit [] {
        let $text = $in

        print ("\n" * $before) -n
        print $text -n
        print ("\n" * $after) -n
    }

    (
        $text_args
        | str join ' '
        | compactit
        | colorit
        | if $frame != ' ' {
            frameit
        } else {}
        | if $echo { } else { newlineit }
    )
}

# > [{a: 1} {b: 2}] | to nuon
# [{a: 1}, {b: 2}]
#
# > [{a: 1} {b: 2}] | fill non-exist | to nuon
# [[a, b]; [1, null], [null, 2]]
def 'fill non-exist' [
    value_to_replace: any = ''
] {
    let $table = $in

    let $cols = (
        $table
        | par-each {|i| $i | columns}
        | flatten
        | uniq
        | reduce --fold {} {|i acc|
            $acc
            | merge {$i: $value_to_replace}
        }
    )

    $table | each {|i| $cols | merge $i}
}

def ansi-code [
    index
    --color_set = [white, grey, cyan]
] {
    (ansi ($color_set | get ($index mod ($color_set | length))))
}