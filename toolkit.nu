use nu-history-tools/ [ analyze-history aggregate-submissions ]

export def 'main' [] { }

export def 'main update-examples' [] {
    aggregate-submissions --quiet
    | update freq_by_user { ansi strip }
    | update importance { math round --precision 2 }
    | save -f ([assets script_results_examples aggregated-submissions.csv] | path join)

    analyze-history --quiet
    | update freq_by_user { ansi strip }
    | update freq_norm { math round --precision 2 }
    | update importance { math round --precision 2 }
    | save -f ([assets script_results_examples nu-hist-stats-example.csv] | path join)
}

export def 'main update-surrogates' [] {
    glob /Users/user/git/nushell/crates/nu-std/std/**/*.nu
    | nu-history-tools analyze-nu-files
    | select name freq
    | sort-by freq
    | save -f stats_submissions/surrogate+nu_std.csv;

    glob /Users/user/git/nu_scripts_upstream/**/*.nu --exclude ['**/themes/**/' '**/before_v0.60/**' '**/custom-completions/**']
    | analyze-nu-files
    | select name freq
    | sort-by freq
    | save -f stats_submissions/surrogate+nu_scripts.csv;
}

export def 'main parse-crates' [
    --output_dir: path = '/Users/user/git/nu-history-tools/assets/crates_parsing/' # A path to output `.csv` results
    --crates_dir: path = '/Users/user/git/nushell/crates/' # A path to a Nushell's git repository
] {
    # This script parses sources of nushell for the last x tags to extract nushell commands
    if not ($output_dir | path exists) {
        error make {msg: 'set an `$output_dir` param'}
    }

    if not ($crates_dir | path exists) {
        error make {msg: 'set an `$crates_dir` param'}
    }

    let $out_csv_long = $output_dir | path join cmds_by_crates_and_tags_long.csv
    let $out_csv_short = $output_dir | path join 'cmds_by_crates_and_tags.csv'

    def parse_crates_from_tag [
        tag?
    ] {
        if $tag != null {
            git checkout $tag
        }

        if $tag in ["0.2.0" "0.3.0" "0.4.0" "0_5_0" "0.6.0" "0.6.1"] {
            cd ../src
        }

        rg 'PluginSignature::build\("(.*)"\)' -o -r '$1' | complete | get stdout
        | append (rg 'fn name.*\n +"(.*)"' -U -o -r '$1' | complete | get stdout)
        | append (rg 'expr_name!.*\n.*\n +"(.*)"' -U -o -r '$1' | complete | get stdout)
        | append (rg 'expr_command!.*\n.*\n +"(.*)"' -U -o -r '$1' | complete | get stdout)
        | append (rg 'lazy_command!.*\n.*\n +"(.*)"' -U -o -r '$1' | complete | get stdout)
        | flatten
        | lines
        | parse "{path}:{name}"
        | upsert crate {|i| $i.path | path split | get 0 }
        | reject path
        | insert tag $tag
        | str replace '0_5_0' '0.5.0' tag
        | sort-by name crate
    }

    if not ($out_csv_long | path exists) {
        $'name,crate,tag(char nl)'
        | save -r $out_csv_long
    }

    let $parsed_tags = open $out_csv_long
    | get tag
    | uniq
    | str replace '0.5.0' '0_5_0'
    | append v0.96.0 # `v` was added by mistake so we ignore that tag

    cd $crates_dir
    git checkout main
    git pull origin main
    mut $current_commit = (git rev-parse HEAD)

    git tag
    | lines
    | where $it not-in $parsed_tags
    | each {|i|
        print -n $'(ansi yellow)parsing ($i) tag: (ansi reset)'

        parse_crates_from_tag $i | sort -n
    }
    | flatten
    | to csv --noheaders
    | save -ar ($out_csv_long)

    git checkout $current_commit # checkout back
    cd -

    let $cmds_agg = open $out_csv_long
    | sort-by tag --natural
    | group-by name
    | values
    | each {|i|
        $i
        | last
        | rename -c {tag: last_tag}
        | merge ($i | first | select tag | rename first_tag)
        | move first_tag --before last_tag
    }
    | flatten
    | sort-by -n last_tag first_tag crate name

    let $cmds_missing = help commands
    | where command_type in ['builtin' 'keyword']
    | get name
    | where $it not-in $cmds_agg.name

    $cmds_agg
    | save -f $out_csv_short

    print $'($out_csv_short) file is saved'
}
