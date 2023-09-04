# Calculate frequencies of use of the "nu" commands in a history
def nu_hist_stats [] {
    history | get command | str join $';(char nl)' | save nushell_hist_for_ast.nu -f

    let $result = (nu_commands_stats nushell_hist_for_ast.nu --extra_graphs)

    rm nushell_hist_for_ast.nu
    $result
}

# Calculate frequencies of use of the "nu" commands in a given .nu files
def nu_files_stats [
    ...file_paths: path
] {
    $in
    | default $file_paths
    | par-each {|i| nu_commands_stats $i}
    | flatten
    | where freq != null
    | group-by name
    | values
    | par-each {|i| $i | get 0 | upsert freq ($i.freq | math sum)}
    | normalize freq
    | upsert freq_norm_bar {|i| bar $i.freq_norm --width 10}
    | sort-by freq -r
}


def nu_commands_stats [
    path: path
    --normalize_freq    # create a normalized freqency column
    --extra_graphs      # produce frequency histogram and timeline sparklines columns
] {
    let $parsed_hist = (
        nu --ide-ast $path --no-config-file --no-std-lib
        | from json
        | where shape in ['shape_internalcall' 'keyword']
    )

    let $freq_record = ($parsed_hist | get content | uniq --count | rename command | transpose -idr)

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

    $freq_builtins_only
    | if $normalize_freq or $extra_graphs {
        normalize freq
    } else {}
    | if $extra_graphs {
        make_extra_graphs
    } else {}
}

# construct bars based of a given percentage from a given width (5 is default)
# https://github.com/nushell/nu_scripts/blob/main/sourced/progress_bar/bar.nu
# > bar 0.2
# █
# > bar 0.71
# ███▌
def 'bar' [
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
def spark [v: list] {
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
    } | str join
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
] {
    mut $table = $in

    for $column in $column_names {
        let $max_value = (
            $table
            | get $column
            | where ($it | describe | $in in ['int' 'decimal'])
            | math max
        )

        $table = (
            $table
            | upsert $'($column)_norm' {
                |i| $i
                | get $column
                | if ($in | describe | $in in ['int' 'decimal']) {
                    $in / $max_value
                } else {}
            }
        )
    }

    $table
}