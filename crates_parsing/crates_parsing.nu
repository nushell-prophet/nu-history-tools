# This script parses sources of nushell for the last x tags to extract nushell commands
print 'this script should be executed being in the "crates" folder of a nushell repository'

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
    | upsert tag $tag
}

let $cmds_in_tags = (git tag | lines | where (($it | str length) == 6) | last 39 | each {|i| parse_crates $i} | flatten)

let $cmds_agg = (
    $cmds_in_tags
    | group-by name
    | values
    | each {
        |i| $i
        | last
        | rename -c [tag last_tag]
        | merge ($i | first | select tag | rename first_tag)
        | move first_tag --before last_tag
        | reject path
    }
    | flatten
    | sort-by last_tag first_tag crate name
);

let $cmds_missing = (
    help commands
    | where command_type in ['builtin' 'keyword']
    | get name
    | where $it not-in $cmds_agg.name
)


# not neccessary step to save the output csv. Let's leave it here for the mainainer
let csv_path = '/Users/user/apps-files/github/nu-commands-frequency-stats/crates_parsing/cmds_by_crates_and_tags.csv'
if ($csv_path | path exists) {
    $cmds_agg
    | save -f $csv_path
}

print '"$cmds_in_tags" variable is availble, here is its content'

$cmds_agg