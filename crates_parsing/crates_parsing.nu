# This script parses sources of nushell for the last x tags to extract nushell commands
print 'this script should be executed being in the "crates" folder of a nushell repository'

let $prew_wd = (pwd)

let $output_dir = '/Users/user/apps-files/github/nu-commands-frequency-stats/crates_parsing/'
let $out_csv_long = ($output_dir | path join cmds_by_crates_and_tags_long.csv)
let $out_csv_short = ($output_dir | path join 'cmds_by_crates_and_tags.csv')
let $crates_dir = '/Users/user/apps-files/github/nushell/crates/'

if ($crates_dir | path exists) {
    cd $crates_dir
} else {
    echo 'provide $crates_dir'
    return
}

def parse_crates [
    tag?
] {
    git checkout ($tag | default (git tag | lines | last));

    rg 'PluginSignature::build\("(.*)"\)' -o -r '$1'
    | append (rg 'fn name.*\n +"(.*)"' -U -o -r '$1')
    | append (rg 'expr_name!.*\n.*\n +"(.*)"' -U -o -r '$1')
    | append (rg 'lazy_command!.*\n.*\n +"(.*)"' -U -o -r '$1')
    | flatten
    | lines
    | parse "{path}:{name}"
    | upsert crate {|i| $i.path | path split | get 0}
    | reject path
    | upsert tag $tag
}

let $current_tags = (
    open $out_csv_long
    | get tag
    | uniq
    | append '0_5_0' #
)

(
    git tag
    | lines
    | where $it not-in $current_tags
    | sort -n
    | each {|i| parse_crates $i}
    | flatten
    | inspect
    | to csv --noheaders
    | save -ar ($out_csv_long)
)

let $cmds_agg = (
    open $out_csv_long
    | group-by name
    | values
    | each {
        |i| $i
        | last
        | rename -c [tag last_tag]
        | merge ($i | first | select tag | rename first_tag)
        | move first_tag --before last_tag
    }
    | flatten
    | sort-by -n last_tag first_tag crate name
);

let $cmds_missing = (
    help commands
    | where command_type in ['builtin' 'keyword']
    | get name
    | where $it not-in $cmds_agg.name
)


# not neccessary step to save the output csv. Let's leave it here for the mainainer
if ($out_csv_short | path exists) {
    $cmds_agg
    | save -f $out_csv_short
}

print '"$cmds_in_tags" variable is availble, here is its content'

cd $pwd

$cmds_agg