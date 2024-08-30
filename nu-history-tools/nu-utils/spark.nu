# send an array into spark and get a sparkline out
# https://github.com/nushell/nu_scripts/blob/main/sourced/fun/spark.nu
# let v = [2, 250, 670, 890, 2, 430, 11, 908, 123, 57]
# > spark $v
# ▁▂▆▇▁▄▁█▁▁

use ansi-alternate.nu

# create a small sparkline graph
export def main [
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
        | each {|i| $'(ansi-alternate $i.index)($i.item)(ansi reset)'}
    } else {}
    | str join
}
