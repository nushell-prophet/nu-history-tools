# Calculate frequencies of use of the "nu" commands in a history
def nu-hist-stats [] {

    cprint 'The script is working with your history. On m1 mac with history of ~40k entries, it runs about a minute.'

    history | get command | str join $';(char nl)' | save nushell_hist_for_ast.nu -f

    let $result = (nu-commands-stats nushell_hist_for_ast.nu --extra_graphs --benchmarks)

    rm nushell_hist_for_ast.nu
    $result
}

# Calculate frequencies of use of the "nu" commands in a given .nu files
def nu_files_stats [
    ...file_paths: path
] {
    $in
    | default $file_paths
    | par-each {|i| nu_commands_stats $i}
    | flatten
    | where freq != null
    | group-by name
    | values
    | par-each {|i| $i | get 0 | upsert freq ($i.freq | math sum)}
    | normalize freq
    | upsert freq_norm_bar {|i| bar $i.freq_norm --width 10}
    | sort-by freq -r
}


def nu-commands-stats [
    path: path
    --normalize_freq    # create a normalized freqency column
    --extra_graphs      # produce frequency histogram and timeline sparklines columns
    --benchmarks        # produce benchmarks columns
] {
    let $parsed_hist = (
        nu --ide-ast $path --no-config-file --no-std-lib
        | from json
        | where shape in ['shape_internalcall' 'keyword']
    )

    let $freq_record = ($parsed_hist | get content | uniq --count | rename command | transpose -idr)

    let $freq_builtins_only = (
        help commands
        | select name category command_type
        | where command_type in ['builtin' 'keyword']
        | reject command_type
        | upsert freq {
            |i| $freq_record
            | get -i $i.name
            | if $in == [] {
                null
            } else {}
        }
        | where freq != null
    )

    def make_extra_graphs [] {
        let $table_in = $in
        let $hist_with_groups = (
            $parsed_hist
            | upsert start {|i| $i.span.start}
            | select content start
            | upsert start {|i| $i.start // 100_000}
            | uniq --count
            | flatten
        );

        let $def_bins = ($hist_with_groups | get start | uniq | sort | reduce -f {} {|a b| $b | merge {$a: 0}})

        let $sparks = (
            $hist_with_groups
            | group-by content
            | items { |a b| {
                $a: ($def_bins
                    | merge ($b | select start count | transpose -idr)
                    | values
                    | spark $in)
                }
            }
            | reduce -f {} {|a b| $a | merge $b}
        )

        $table_in
        | upsert 'freq_norm_bar' {|i| bar $i.freq_norm --width 10}
        | upsert timeline {
            |i| $sparks
            | get -i $i.name
        }
    }

    $freq_builtins_only
    | if $normalize_freq or $extra_graphs {
        normalize freq
    } else {}
    | if $extra_graphs {
        make_extra_graphs
    } else {}
    | if $benchmarks {
        make_benchmarks
    } else {}
}

def make_benchmarks [] {
    let $data = $in

    cprint --before 1 $'*Small note about columns*:'
    cprint '- *timeline* - represents dynamics, when through your history the command was used'
    cprint '- *users_count* - represents how many users who shared their stats used this command too'
    cprint '- *freq_norm_avg* - represents the average normalized frequency between users, who shared their stats'
    cprint '- *users_sparkline* - each bar in the sparkline column represent 1 users, sorted in the way below'

    cprint --before 1 'The column *users_sparkline* is ordered in this way:'
    print (
        [
            [user, count]; [nu_scripts, 61840], [maximuvarov, 26526], ["shinyzero0", 8796], [fdncred, 17258],
            [chtenb, 2638], [kubouch, 9159], [dazfuller, 7354], [cptpiepmatz, 4199], [ErichDonGubler, 3382],
            [zjp, 2643], [sholderbach, 2005], [horasal, 1363], [nu_std, 1139], [pingiun, 884], [nicokosi, 255]
        ]
    )
    let $benchmarks = (benchmarks | group-by name);

    $data
    | each {|i| $i | merge ($benchmarks | get $i.name -i | get 0 -i | default {})}
}

# Ready to use benchmarks table.
# How to update:
# source v1-sourced-analytics.nu
# $3_analytics | rename name | reject category | upsert dummy '' | to csv | pbcopy
def 'benchmarks' [] {
'name,users_count,freq_norm_avg,users_sparkline,freq_norm_avg_bar,dummy
ls,14,0.7651494388515447,▆▆██▁█▄▄██▆█▁▆▇,██████████▊   ,
cd,14,0.550949058398355,▂▃▁▄█▇██▃▇▄▄▁█▁,███████▊      ,
get,15,0.39410354309311973,██▄▅▁▆▃▁▁▂▃▂▃▂█,█████▌        ,
help,13,0.38887524504985865,▂▃▂▅▁▃▂▂▁▃█▁▁▇█,█████▌        ,
open,15,0.3715681559911997,▆█▄▄▁▄▃▆▂▂▃▃▁▂▇,█████▎        ,
overlay,2,0.2789422894509141,▁▁▁▁▁█▁▁▁▁▁▁▁▁▁,███▉          ,
let,13,0.26858358046614544,█▆▂▅▁▃▁▁▁▃▂▂▇▃▁,███▊          ,
if,8,0.22733352427905018,▃▂▁▂▁▂▁▁▁▁▂▁█▁▁,███▏          ,
source,10,0.2257818617994543,▅▆▁▆▆▄█▂▁▂▁▁▁▄▁,███▏          ,
extern,2,0.2102672927578111,▁▁▁▁▁▇▁▁▁▁▁▁▁█▁,███           ,
config,14,0.20860158420862612,▁▃▅▃▂█▁▂▂▆▂▂▁▆▅,██▉           ,
upsert,4,0.20384913083731993,██▁▃▁▁▁▁▁▁▁▁▁▁▁,██▉           ,
where,12,0.1977431735908617,▆█▄▇▁▆▅▃▂▂▇▄▄▁▁,██▊           ,
encode,4,0.18449734505281395,▁▁▁▁▁▄▁▁▁▁▁█▁▁▁,██▋           ,
each,13,0.17921734361505262,██▃▅▁▇▁▂▂▂▄▃▃▁▁,██▌           ,
dfr open,4,0.1603655722889266,▁▂▁▁▁▁▁▁▁▁▁▁▁▁█,██▎           ,
profile,7,0.1578988592647105,▁▁▂▁▁█▁▁▁▁▁▁▁▆▁,██▎           ,
debug,9,0.15536388155839795,▁▁▁▃▁▂▁▃▁█▁▂▁▃▁,██▏           ,
ansi,8,0.1525072887264996,▃▂▁▂▁▁▁▁▁▁▂▁█▁▁,██▏           ,
ps,7,0.14371503010863637,▁▁▂▂█▁▁▁▁▁▂▁▁▅▁,██            ,
echo,12,0.14084084057601062,▂▃▂▃▁▂▁▁▂▃▅▁▁█▇,██            ,
path,10,0.1382157488245359,▁▄▁▄▁▅▂▅▃█▁▄▁▇▁,█▉            ,
def,8,0.13352601812343798,▅▃▂▅▁▄▁▁▁▁▄▁█▄▁,█▉            ,
overlay use,3,0.12442107118575961,▅█▁▁▁▃▁▁▁▁▁▁▁▁▁,█▊            ,
sys,8,0.12164064427774061,▁▁▁▁▁▁▁▁▁▂▂▁▁▁█,█▊            ,
rm,14,0.12064868973449719,▂▂▅▂▁▃▃▃▃▅▂▂▁█▁,█▊            ,
lines,13,0.11891035304174201,▆▅█▆▂▇▂▆▃█▆▃▂▁▁,█▋            ,
run-external,2,0.11775360815330606,▁▁▁▁▁▁▁▁▁▁▁▁▁█▁,█▋            ,
from json,8,0.11730166563880755,▆▇▄▃▁▁▃▂▁▁█▁▁▁▁,█▋            ,
first,11,0.11420353589609285,▆█▁▃▁▁▁▃▂▂▂▁▁▁▁,█▋            ,
select,10,0.11402593021716942,▆█▂▅▁▁▅▃▄▁▁▂▂▁▁,█▋            ,
decode,3,0.11187819760503122,▁▁▁▂▁▁▁▁▁▁▁█▁▁▁,█▋            ,
dfr into-df,3,0.10926945930511485,█▄▁▁▁▁▁▁▁▁▁▁▁▁▁,█▌            ,
length,8,0.10617865701820477,▇█▂▃▁▃▁▁▁▁▂▁▃▁▁,█▌            ,
table,10,0.10061413506674581,▂▂▂▇▁▄▂▁▁▃▄▁▁▁█,█▍            ,
http get,7,0.09542101961212292,▂▁▃▃▁▁▂█▁▁▁▁▁▆▁,█▍            ,
let-env,8,0.09347764929085621,▂▂▂▄▁▅▁▂▁█▁▁▁▆▁,█▎            ,
sort-by,10,0.09344751995231962,▅▇▂▄▁▃▁▁▁▁▂▂▁▁█,█▎            ,
find,11,0.09259118256033308,▂▂▃▃▂▄▁▁▁▂▂▁▂▃█,█▎            ,
flatten,9,0.09244912825274251,██▃▅▁▅▃▁▂▁▆▁▅▁▁,█▎            ,
print,11,0.0915784990498225,▅▄▄▅▁▂▁▁▂█▃▂▂▆▁,█▎            ,
clear,5,0.09153908971846937,▁▁▁▁▁▁█▂▁▁▁▁▁▁▁,█▎            ,
all,10,0.08848762943469927,▁▂▁▂▂█▂▂▆▁▅▁▁▁▁,█▎            ,
url,3,0.08793047941017429,▁▁▁▂▁▁▁▁▁▁█▁▁▁▁,█▎            ,
dfr into-nu,1,0.08784058560390402,█▁▁▁▁▁▁▁▁▁▁▁▁▁▁,█▎            ,
export def,4,0.08638484909767502,▃▂▁▁▁▂▁▁▁▁▁▁█▁▁,█▎            ,
do,10,0.08370927422501054,▃▃▂▃▁▂▁▂▁▄▄▁▂█▁,█▏            ,
exit,6,0.08262058402835461,▂▁▁▁▁▂▁▅█▁▁▅▁▁▁,█▏            ,
is-empty,7,0.08187675850351663,▂▁▁▁▁▁▁▁▁▁▂▁█▁▁,█▏            ,
dfr col,3,0.08020998246144918,█▄▁▁▁▁▁▁▁▁▁▄▁▁▁,█▏            ,
last,8,0.07858472602437548,▆▅▄▄▁█▁▃▁▁▁▁▁▁▁,█▏            ,
par-each,3,0.07817367687611693,▅█▁▁▁▁▁▁▁▁▁▁▂▁▁,█▏            ,
which,12,0.0762771597324773,▂▂▃▂▁▂▁▂▁▄▁▂▁█▁,█▏            ,
commandline,3,0.07615980520609618,▁▁▁▁▁▁▁▁▁▁█▁▁▁▁,█▏            ,
transpose,9,0.07611493465707637,▅▇▂█▁▃▂▁▁▁▇▁▂▇▁,█▏            ,
str replace,7,0.07597032105951018,█▇▃▅▁▁▁▃▁▂▁▁▁▁▁,█▏            ,
str join,9,0.07581631788424176,▅▃▂▃▁▁▁▁▄▃▆▃█▁▁,█             ,
update,12,0.07334264543901427,▁▂▄▅▄▆█▅▃▂▃▁▃▁▁,█             ,
describe,9,0.0731072733569514,▄▄▇▅▁▃▁▁▂▂█▁▃▁▁,█             ,
into,4,0.07277982919784531,▁▁▁▃▁▂▁▁▁▁█▁▁▁▁,█             ,
reverse,4,0.07004617227738288,▂▅▁▂▁▁▁▁▁▁█▁▁▁▁,█             ,
split row,6,0.06835952597783128,▆▆▃▄▁▂▁▁▁▁▁▁▁█▁,█             ,
history,7,0.06779929789794525,▆█▃█▂▂▁▁▁▁▅▁▁▁▁,█             ,
metadata,5,0.06636919053613619,▁▁▁▁▁▁▃▁▁▁▃▁█▁▁,▉             ,
from,10,0.06585739796680573,▁█▁▂▁▂▂█▂▁▂▁▁▁▁,▉             ,
append,7,0.06519455346923096,▇█▃▃▁▄▁▁▄▁▁▁▆▁▁,▉             ,
version,10,0.06411514421264611,▁▁▂▂▁▂▂▁▁▃▃▂▁█▁,▉             ,
skip,8,0.0635936351165983,▅▇▃▄▁█▁▁▇▁▁▁▂▁▁,▉             ,
parse,8,0.06328893410674308,▅█▄▄▁▂▁▂▂▁▁▁▁▁▁,▉             ,
config nu,4,0.06277838892276784,▅█▁▁▁▃▁▁▁▁▇▁▁▁▁,▉             ,
char,6,0.06273123482704046,▄▂▁▅▁▃▁▁▁▁▁▁▄█▁,▉             ,
use,8,0.060609789950156596,▃▂▂▂▁█▃▁▁▁▁▁▂▇▁,▉             ,
save,12,0.06059814352327781,▇█▅▃▁▃▂▄▂▂▅▃▁▁▁,▉             ,
to yaml,2,0.058408319965115994,█▁▁▁▁▁▁▁▁▁▁▁▁▁▁,▉             ,
merge,8,0.05817461253473597,▄▄▂█▁▄▄▁▃▁▁▁▂▁▁,▉             ,
from nuon,2,0.05814954291476098,▁▁▁▁▁▁▁▁▁▁█▁▁▁▁,▉             ,
register,6,0.05799696095581814,▁▁▁▆▁▂▁█▁▁▁▆▁▁▁,▊             ,
uniq,5,0.057951801685949156,▆█▃▃▁▁▁▁▁▁█▁▁▁▁,▊             ,
any,7,0.05778005758561016,▁▁▃▂▁▁▁▁▂▃█▁▂▁▁,▊             ,
from tsv,4,0.05763206557389921,▁▂▁▁▁▁▁▁▁▁█▁▁▁▁,▊             ,
continue,2,0.057257320339402666,▁▁▁▁▂▁▁▁█▁▁▁▁▁▁,▊             ,
to text,9,0.0562311669707084,▁▂▄▃▁▁▁▄▁▄█▃▁▁▁,▊             ,
mv,9,0.05486192864175544,▃▂▇▂▁▅▅▂▄█▁▁▁▁▁,▊             ,
dfr with-column,2,0.05409508161045937,█▄▁▁▁▁▁▁▁▁▁▁▁▁▁,▊             ,
explore,6,0.053099018733419656,▂▃▂▆▁▁▁█▁▁▇▁▁▁▁,▊             ,
try,8,0.052709071847643896,▂▂▁▂▁▁▁▁▆▁▅▁▄█▁,▊             ,
dfr filter-with,3,0.05138677044622928,▇█▁▁▁▁▁▁▁▁▁▆▁▁▁,▊             ,
dfr select,2,0.050826175080994476,█▄▁▁▁▁▁▁▁▁▁▁▁▁▁,▊             ,
into datetime,4,0.04889922032697153,▄▄▁█▁▁▁▂▁▁▁▁▁▁▁,▋             ,
fill,5,0.04886448128320527,▂▂▁▁▁▁▁▁▁▁█▁▁▁▁,▋             ,
complete,8,0.0488183486268966,▂▃▂▂▁▁▁▂▁▁▁▁▁█▁,▋             ,
group-by,6,0.048260449357989836,▅▄▁▅▁█▂▁▁▁▁▁▁▁▁,▋             ,
mkdir,9,0.047820695745966965,▂▃▄▂▁▄▄▃▁▄█▁▁▁▁,▋             ,
into int,7,0.045266319758057116,▆█▁▇▁▃▂▃▁▁▁▁▃▁▁,▋             ,
module,3,0.04502962962838297,▁▁▁▁▁█▁▁▁▁▁▁▁▁▁,▋             ,
timeit,7,0.044792377947274656,▅▃▃▂▁▁▂▁▁█▁▁▁▁▁,▋             ,
dfr filter,3,0.04471150212355179,▄▂▁▁▁▁▁▁▁▁▁█▁▁▁,▋             ,
bytes at,1,0.04459016393442623,▁▁▁█▁▁▁▁▁▁▁▁▁▁▁,▋             ,
http,4,0.04399300621939248,▁▁▄▂▁▁▁█▁▁▁▁▁▁▁,▋             ,
dfr into-lazy,2,0.04366452876501987,█▇▁▁▁▁▁▁▁▁▁▁▁▁▁,▋             ,
cp,7,0.043010678869086334,▂▃▅▂▁▅▁▁▃█▁▁▁▁▁,▋             ,
default,7,0.042223877060348705,▄▄▃▅▁█▁▁▄▁▁▁▄▁▁,▋             ,
from xml,3,0.041041104883756625,▁▁▂▁▁█▁▁▁▁▁▁▁▁▁,▋             ,
start,6,0.040773243937041466,▂▃▃▂▁▁▁█▃▁▁▁▁▁▁,▋             ,
dfr sort-by,3,0.04061904404496606,▇█▁▁▁▃▁▁▁▁▁▁▁▁▁,▋             ,
to,9,0.04055254146918566,▁█▃▂▄▄▂▄▄▁▁▁▁▁▁,▋             ,
error make,5,0.04044400735138289,▁▁▁▂▁▂▁▁▁▁▅▁█▁▁,▋             ,
glob,5,0.040038517855632394,█▅▃▄▁▁▂▁▁▁▁▁▁▁▁,▌             ,
size,7,0.03963271783815788,▁█▂▆▁▆▂▁▁▁▁▄▁▁▁,▌             ,
for,10,0.03905551718650304,▂▂▃▄▄▂▁▁▄▁█▁▂▁▁,▌             ,
input,6,0.03897064551186057,▁▁▂▂▂▁█▁▁▁▁▁▁▁▁,▌             ,
ignore,5,0.03881902140969991,▁▂▂▁▁▁▁▁▁▁▁▁▁█▁,▌             ,
filter,8,0.038441966963626714,▂▁▂▂▁▂▂▅▁█▁▁▄▁▁,▌             ,
help commands,7,0.038210811599707226,▃▂▁█▁▃▂▄▁▁▁▇▁▁▁,▌             ,
into binary,4,0.038186105233029774,▂▂▁█▁▁▁▁▁▁▁▅▁▁▁,▌             ,
str substring,5,0.03796891483098941,▅▆▁▂▁▁▁▁▁▁█▁▂▁▁,▌             ,
mut,6,0.037646490822794386,▃▃▂▃▁▅▁▁▁▁▁▁█▁▁,▌             ,
dfr rename,2,0.037640523316825436,██▁▁▁▁▁▁▁▁▁▁▁▁▁,▌             ,
reject,8,0.03743484254432133,█▆▃▄▁▄▁▂▃▁▁▁▃▁▁,▌             ,
prepend,5,0.036951413449424965,▂▁▂▂▁▁▁▁▁▁▁▁▁█▁,▌             ,
reduce,5,0.036778981709792435,██▃▆▁▁▁▁▁▁▁▁▄▁▁,▌             ,
# construct bars based of a given percentage from a given width (5 is default)
# https://github.com/nushell/nu_scripts/blob/main/sourced/progress_bar/bar.nu
# > bar 0.2
# █
# > bar 0.71
# ███▌
def 'bar' [
    percentage: float
    --background (-b): string = 'default'
    --foreground (-f): string = 'default'
    --progress (-p) # output the result using 'print -n'
    --width (-w): int = 5
] {
    let blocks = [null "▏" "▎" "▍" "▌" "▋" "▊" "▉" "█"]
    let $whole_part = (($blocks | last) * ($percentage * $width // 1))
    let $fraction = (
        $blocks
        | get (
            ($percentage * $width) mod 1
            | $in * ($blocks | length | $in - 1)
            | math round
        )
    )

    let result = (
        $"($whole_part)($fraction)"
        | fill -c $' ' -w $width
        | if ($foreground == 'default') and ($background == 'default') {} else {
            $"(ansi -e {fg: ($foreground), bg: ($background)})($in)(ansi reset)"
        }
    )

    if $progress {
        print -n $"($result)\r"
    } else {
        $result
    }
}

# send an array into spark and get a sparkline out
# https://github.com/nushell/nu_scripts/blob/main/sourced/fun/spark.nu
# let v = [2, 250, 670, 890, 2, 430, 11, 908, 123, 57]
# > spark $v
# ▁▂▆▇▁▄▁█▁▁

# create a small sparkline graph
def spark [v: list] {
    let TICKS = [(char -u "2581")
              (char -u "2582")
              (char -u "2583")
              (char -u "2584")
              (char -u "2585")
              (char -u "2586")
              (char -u "2587")
              (char -u "2588")]

    let min = ($v | math min)
    let max = ($v | math max)
    let ratio = (if $max == $min { 1.0 } else { 7.0 / ($max - $min)})
    $v | each { |e|
        let i = ((($e - $min) * $ratio) | math round)
        $"($TICKS | get $i)"
    } | str join
}

# normalize values in given columns
# > [[a b]; [1 2] [3 4] [a null]] | normalize a b
# ┏━━━┳━━━┳━━━━━━━━┳━━━━━━━━┓
# ┃ a ┃ b ┃ a_norm ┃ b_norm ┃
# ┣━━━╋━━━╋━━━━━━━━╋━━━━━━━━┫
# ┃ 1 ┃ 2 ┃   0.33 ┃   0.50 ┃
# ┃ 3 ┃ 4 ┃      1 ┃      1 ┃
# ┃ a ┃   ┃        ┃        ┃
# ┗━━━┻━━━┻━━━━━━━━┻━━━━━━━━┛
def normalize [
    ...column_names
] {
    mut $table = $in

    for $column in $column_names {
        let $max_value = (
            $table
            | get $column
            | where ($it | describe | $in in ['int' 'decimal'])
            | math max
        )

        $table = (
            $table
            | upsert $'($column)_norm' {
                |i| $i
                | get $column
                | if ($in | describe | $in in ['int' 'decimal']) {
                    $in / $max_value
                } else {}
            }
        )
    }

    $table
}