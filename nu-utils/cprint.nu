# Print a string colorfully with bells and whistles
export def main [
    text?: string # text to format, if omitted stdin will be used
    --color (-c): string@'nu-complete-colors' = 'default' # color to use for the main text
    --highlight_color (-H): string@'nu-complete-colors' = 'green_bold' # color to use for highlighting text enclosed in asterisks
    --frame_color (-r): string@'nu-complete-colors' = 'dark_gray' # color to use for frame
    --frame (-f): string = '' # symbol (or a string) to frame a text
    --lines_before (-b): int = 0 # number of new lines before a text
    --lines_after (-a): int = 1 # number of new lines after a text
    --echo (-e) # echo text string instead of printing
    --keep_single_breaks # don't remove single line breaks
    --width (-w): int = 80 # the total width of text to wrap it
    --indent (-i): int = 0 # indent output by number of spaces
    --align: string = 'left' # alignment of text
]: [nothing -> string, string -> string] {
    let $text = if $text == null {} else {$text}

    let $width_safe = width-safe $width $indent

    $text
    | wrapit $keep_single_breaks $width_safe $indent
    | colorit $highlight_color $color
    | alignit $align $width_safe
    | if $frame != '' {
        frameit $width_safe $frame $frame_color
    } else {}
    | indentit $indent
    | newlineit $lines_before $lines_after
    | if $echo { } else { print -n $in }
}

# I `export` commands here to make them available for testing, yet to be included
# in the same file, so cprint could be easily copied to other projects

export def width-safe [
    $width
    $indent
] {
    term size
    | get columns
    | [$in $width] | math min
    | $in - $indent
    | [$in 1] | math max # term size gives 0 in tests
}

export def wrapit [
    $keep_single_breaks
    $width_safe
    $indent
] {
    str replace -r -a '(?m)^[\t ]+' ''
    | if $keep_single_breaks { } else {
        remove_single_nls
    }
    | str replace -r -a '[\t ]+$' ''
    | str replace -r -a $"\(.{1,($width_safe)}\)\(\\s|$\)|\(.{1,($width_safe)}\)" "$1$3\n"
    | str replace -r $'(char nl)$' '' # trailing new line
}

export def remove_single_nls [] {
    str replace -r -a '(\n[\t ]*(\n[\t ]*)+)' '⏎'
    | str replace -r -a '\n' ' ' # remove single line breaks used for code formatting
    | str replace -a '⏎' "\n\n"
}

export def newlineit [
    $before
    $after
] {
    $"((char nl) | str repeat $before)($in)((char nl) | str repeat $after)"
}

export def frameit [
    $width_safe
    $frame
    $frame_color
] {
    let $input = $in

    $frame
    | str repeat $width_safe
    | str substring --grapheme-clusters 1..($width_safe) # in case that frame has more than 1 chars
    | $'(ansi $frame_color)($in)(ansi reset)'
    | $in + "\n" + $input + "\n" + $in
}

export def colorit [
    $highlight_color
    $color
] {
    str replace -r -a '\*([\s\S]+?)\*' $'(ansi reset)(ansi $highlight_color)$1(ansi reset)(ansi $color)'
    | $'(ansi $color)($in)(ansi reset)'
}

export def alignit [
    $alignment: string
    $width_safe
] {
    lines
    | each {
        fill --alignment $alignment --width $width_safe
    }
    | str join (char nl)
}


export def indentit [
    $indent
] {
    str replace -r -a '(?m)^(.)' $'((char sp) | str repeat $indent)$1'
}

def 'str repeat' [
    $n
] {
    let $text = $in
    seq 1 $n | each {$text} | str join
}

def 'nu-complete-colors' [] {
    ansi --list | take until {|it| $it.name == reset} | get name
}
