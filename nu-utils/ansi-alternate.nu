# A helper to provide ansi code color alternations
# > ansi-alternate 2
#
# [36m
# > ansi-alternate 5
#
# [36m
# > ansi-alternate 3
#
# [37m
export def main [
    index
    --color_set = [white, grey, cyan]
] {
    $color_set | get ($index mod ($color_set | length)) | ansi $in
}
