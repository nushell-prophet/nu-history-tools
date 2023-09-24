# This script parses sources of nushell for the last x tags to extract nushell commands

let $prew_wd = (pwd)

let $OUTPUT_DIR = '/Users/user/apps-files/github/nu-commands-frequency-stats/crates_parsing/'

let $output_dir = (
        if ($'($prew_wd)/crates_parsing.nu' | path exists) { # true means that this script is executed in a `crates_parsing` folder
            $prew_wd
        } else {
            if ($OUTPUT_DIR | path exists) {
                $OUTPUT_DIR
            } else {
                error make {msg: 'run this script from `crates_parsing` dir or set `$OUTPUT_DIR` variable in the script body'}
            }
        }
    )

let $out_csv_long = ($output_dir | path join cmds_by_crates_and_tags_long.csv)
let $out_csv_short = ($output_dir | path join 'cmds_by_crates_and_tags.csv')
let $crates_dir = '/Users/user/apps-files/github/nushell/crates/'

if not ($crates_dir | path exists) {
    error make {msg: 'provide $crates_dir'}
}

def parse_crates_from_tag [
    tag?
] {
    git checkout ($tag | default (git tag | lines | last));

    rg 'PluginSignature::build\("(.*)"\)' -o -r '$1'
    | append (rg 'fn name.*\n +"(.*)"' -U -o -r '$1')
    | append (rg 'expr_name!.*\n.*\n +"(.*)"' -U -o -r '$1')
    | append (rg 'expr_command!.*\n.*\n +"(.*)"' -U -o -r '$1')
    | append (rg 'lazy_command!.*\n.*\n +"(.*)"' -U -o -r '$1')
    | flatten
    | lines
    | parse "{path}:{name}"
    | upsert crate {|i| $i.path | path split | get 0}
    | reject path
    | upsert tag $tag
}

if not ($out_csv_long | path exists) {
    $'name,crate,tag(char nl)'
    | save -r $out_csv_long
}

let $current_tags = (
    open $out_csv_long
    | get tag
    | uniq
    | append '0_5_0'
)

(
    cd $crates_dir;

    git tag
    | lines
    | where $it not-in $current_tags
    | sort -n
    | each {|i| print -n $'parsing ($i) tag: '; parse_crates_from_tag $i}
    | flatten
    | to csv --noheaders
    | save -ar ($out_csv_long);

    cd $prew_wd
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

(
    $cmds_agg
    | save -f $out_csv_short
)

print '"$cmds_agg" variable is availble, here is its content'

# cd $prew_wd

# $cmds_agg