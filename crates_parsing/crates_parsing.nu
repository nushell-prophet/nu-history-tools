# This script parses sources of nushell for the last x tags to extract nushell commands

# A path to output `.csv` results
let $OUTPUT_DIR = '/Users/user/apps-files/github/nu-commands-frequency-stats/crates_parsing/'

# A path to a Nushell's git repository
let $CRATES_DIR = '/Users/user/apps-files/github/nushell/crates/'

if not ($OUTPUT_DIR | path exists) {
    error make {msg: 'set an `$OUTPUT_DIR` variable in the body of `crates_parsing.nu` script'}
}

if not ($CRATES_DIR | path exists) {
    error make {msg: 'set an `$CRATES_DIR` variable in the body of `crates_parsing.nu` script'}
}


let $out_csv_long = ($OUTPUT_DIR | path join cmds_by_crates_and_tags_long.csv)
let $out_csv_short = ($OUTPUT_DIR | path join 'cmds_by_crates_and_tags.csv')

def parse_crates_from_tag [
    tag?
] {
    git checkout ($tag | default (git tag | lines | last));

    if $tag in ["0.2.0", "0.3.0", "0.4.0", "0.5.0", "0.6.0", "0.6.1"] {
        cd ../src
    }

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
    | upsert tag ($tag | str replace '0_5_0' '0.5.0')
    | sort-by 'name'
}

if not ($out_csv_long | path exists) {
    $'name,crate,tag(char nl)'
    | save -r $out_csv_long
}

let $parsed_tags = (
    open $out_csv_long
    | get tag
    | uniq
    | str replace '0.5.0' '0_5_0'
)

(
    cd $CRATES_DIR;
    mut $current_commit = (git rev-parse HEAD);

    git tag
    | lines
    | where $it not-in $parsed_tags
    | sort -n
    | each {|i| print -n $'(ansi yellow)parsing ($i) tag: (ansi reset)'; parse_crates_from_tag $i}
    | flatten
    | to csv --noheaders
    | save -ar ($out_csv_long);

    git checkout $current_commit; # checkout back
    cd -
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

print $'($out_csv_short) file is saved and `$cmds_agg` variable is availble.'

# $cmds_agg