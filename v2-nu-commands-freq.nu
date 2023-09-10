# Calculate frequencies of use of the "nu" commands in a history

export def nu-hist-stats [] {

    cprint 'The script is working with your history. On an M1 Mac with a history of ~40,000 entries, it runs for about a minute.'

    mkdir private_data_gitignore
    history | get command | str join $';(char nl)' | save private_data_gitignore/nushell_hist_for_ast.nu -f

    let $result = (nu-commands-stats private_data_gitignore/nushell_hist_for_ast.nu --extra_graphs | make_benchmarks)

    rm private_data_gitignore -r
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
    | upsert freq_norm_bar {|i| bar $i.freq_norm --width 10}
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
        | where freq != null
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
    | save -f $'results_submissions/v2_(date now | format date '%Y-%m-%d')+WriteYourNick.csv'

    $output
}

# parse submitted stats from a folder
export def aggregate-submissions [
    --select    # flag invokes interactive users selection (during script running)
] {

    let $color_set = [white, grey, cyan]

    let $0_commands_all = (
        help commands
        | select name category command_type
        | rename name
        | where command_type in ['builtin' 'keyword']
        | reject command_type
    );

    let $0_stat = (
        ls results_submissions/*.csv --full-paths
        | sort-by size -r
        | get name
        | where $it !~ 'WriteYourNick.csv'
        | if $select {
            each {|i| $i | path relative-to (pwd)}
            | input list --multi
        } else {}
        | par-each {
            |filename|
            open $filename
            | if ('command_type' in ($in | columns)) {
                reject command_type
            } else {}
            | if ('freq' in ($in | columns)) { # legacy quick fixes
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
        | upsert user {|i| $'(ansi ($color_set | get ($i.index mod ($color_set | length))))($i.user)'}
    )

    cprint --before 1 '- *users_sparkline* is ordered by *sum of executed commands*:'
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
        | each {|b| {name: $b.name.0, users_sparkline: (spark $b.count_norm --colors --color_set $color_set)}}
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
                users_count: ($b | length),
                users_freq_norm_avg: ($b.count_norm | math avg),
                users_sparkline: ($3_sparklines | get $name),
            }
        }
        | upsert users_c_rank {
            |i| ($i.users_count * $i.users_freq_norm_avg) | math sqrt # geometric mean
        }
        | normalize users_c_rank --suffix ''
        | sort-by users_c_rank -r
        | upsert users_c_rank_bar {|i| bar $i.users_c_rank --width ('users_c_rank_bar' | str length)}
    );

    cprint '*users_c_rank* is the normalized geometric mean of *users_count* and *users_freq_norm_avg*.'

    $4_analytics
}

export def make_benchmarks [] {
    let $data = $in

    cprint --before 1 $'*A note about some columns*:'
    cprint '- *timeline* - represents dynamics, showing when the command was used throughout your history'
    cprint '- *users_c_rank* - is the geometric mean of the number of users who used this command and average_norm_frequency'
    cprint --after 1 '- *users_sparkline* - each bar in the sparkline column represents 1 user.'

    let $benchmarks = (
        aggregate-submissions
        | select name users_c_rank users_c_rank_bar users_sparkline
        | group-by name
    );

    $data
    | each {|i| $i | merge ($benchmarks | get $i.name -i | get 0 -i | default {})}
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
        | each {|i| $'(ansi ($color_set | get ($i.index mod ($color_set | length))))($i.item)'}
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
    --frame (-f): string        # A symbol (or a string) to frame text
    --before (-b): int = 0      # A number of new lines before text
    --after (-a): int = 1       # A number of new lines after text
    --echo (-e)                 # Echo text string instead of printing
] {
    def compactit [] {
        $in
        | str replace -r -a '(\n[\t ]*(\n[\t ]*)+)' '⏎'
        | str replace -r -a '\n?[\t ]+' ' '    # remove single line breaks used for code formatting
        | str replace -a '⏎' "\n\n"
        | lines
        | each {|i| $i | str trim}
        | str join "\n"
    }

    def colorit [] {
        let text = ($in | split chars)
        mut agg = []
        mut open_tag = true

        for i in $text {
            if $i == '*' {
                if $open_tag {
                    $open_tag = false
                    $agg = ($agg | append $'(ansi reset)(ansi $highlight_color)')
                } else {
                    $open_tag = true
                    $agg = ($agg | append $'(ansi reset)(ansi $color)')
                }
            } else {
                $agg = ($agg | append $i)
            }
        }

        $agg
        | str join ''
        | $'(ansi $color)($in)(ansi reset)'
    }

    def frameit [] {
        let $text = $in
        let $width = (
            term size
            | get columns
            | ($in / ($frame | str length) | math round)
            | $in - 1
            | [$in 1]
            | math max  # term size gives 0 in tests
        )
        let $line = (
            ' '
            | fill -a r -w $width -c $frame
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
        | if $frame != null {
            frameit
        } else {}
        | if $echo { } else { newlineit }
    )
}
