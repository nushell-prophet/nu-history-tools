# > [{a: 1} {b: 2}] | to nuon
# [{a: 1}, {b: 2}]
#
# > [{a: 1} {b: 2}] | fill non-exist | to nuon
# [[a, b]; [1, null], [null, 2]]
export def main [
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