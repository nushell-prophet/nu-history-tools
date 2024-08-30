# > [{a: 1} {b: 2}] | to nuon
# [{a: 1}, {b: 2}]
#
# > [{a: 1} {b: 2}] | fill non-exist | to nuon
# [{a: 1, b: ""}, {b: 2, a: ""}]
export def main [
    value_to_replace: any = ''
] {
    let $table = $in

    $table
    | columns
    | reduce -f $table {|i| default $value_to_replace $i}
}
