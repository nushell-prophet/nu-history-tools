# normalize values in given columns
# > [[a b]; [1 2] [3 4] [a null]] | normalize a b
# ┏━━━┳━━━┳━━━━━━━━┳━━━━━━━━┓
# ┃ a ┃ b ┃ a_norm ┃ b_norm ┃
# ┣━━━╋━━━╋━━━━━━━━╋━━━━━━━━┫
# ┃ 1 ┃ 2 ┃   0.33 ┃   0.50 ┃
# ┃ 3 ┃ 4 ┃      1 ┃      1 ┃
# ┃ a ┃   ┃        ┃        ┃
# ┗━━━┻━━━┻━━━━━━━━┻━━━━━━━━┛
export def main [
    ...column_names
    --suffix = '_norm'
] {
    mut $table = $in

    for column in $column_names {
        let $max_value = (
            $table
            | get $column
            | where ($it | describe | $in in ['int' 'float'])
            | math max
        )

        $table = (
            $table
            | into float freq
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
