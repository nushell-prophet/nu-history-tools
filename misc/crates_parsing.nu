#crates_parsing

def parse_crates [
    tag?
] {
    let $tag_default = ($tag | default (git tag | lines | last))
    git checkout $tag_default

    let $plugin_crates = (rg 'PluginSignature::build\("(.*)"\)' --json | from json -o | where type == 'match' | get data | select path lines | flatten | upsert command {|i| $i.lines_text | lines | get 0 | str replace -r '(?m).*"(.*?)".*' '$1'} | reject lines_text | upsert crate {|i| $i.text | path split | get 0} | reject text); $plugin_crates
    let $main_crates = (rg 'fn name.*\n.*"(.*)"?' -U --json | from json -o | where type == 'match' | get data | select path lines | flatten | upsert command {|i| $i.lines_text | lines | get 1 | str replace -r '(?m).*"(.*?)".*' '$1'} | reject lines_text | upsert crate {|i| $i.text | path split | get 0} | reject text ); $main_crates

    $main_crates | append $plugin_crates | upsert tag $tag
}

let $commands_in_tags = (git tag | lines | where (($it | str length) == 6) | last 10 | each {|i| parse_crates $i})

let $commands_with_first_tag = ($commands_in_tags | flatten | group-by command | values | each {|i| $i | get 0} | flatten);

let $commands_missing = (help commands | where command_type in ['builtin' 'keyword'] | get name | where $it not-in $commands_with_first_tag.command)

$commands_with_first_tag