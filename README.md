<h1 align="center">nu-history-tools</h1>
<h3 align="center">Nushell🚀 module for commands history analytics</h3>

A Nushell module to analyze the command frequencies in Nushell history, generate cool graphs, benchmark statistics with other users, and generate a file with statistics to share with the community.

Aggregated results, produced by the `aggregate-submissions` command can be found in the [csv file](https://github.com/nushell-prophet/nu-history-tools/tree/main/assets/script_results_examples/aggregated-submissions.csv)

The history of nushell commands by releases can be found in [this csv](https://github.com/nushell-prophet/nu-history-tools/blob/main/assets/crates_parsing/cmds_by_crates_and_tags.csv)

![nu-history-tools2](https://github.com/nushell-prophet/nu-history-tools/assets/4896754/5053ede0-d53a-46be-bd71-7f066eca7025)

## nushell-history-tools video demo

<a href="https://youtu.be/dbRjBsaH_VY">
  <img src="https://github.com/user-attachments/assets/fdd07bfc-7d77-4dca-8a1c-3e27ac3063f9" alt="nushell-history-tools demo" width="100"/>
</a>


## Installation

```nushell no-run
> git clone https://github.com/nushell-prophet/nu-history-tools; cd nu-history-tools; use nu-history-tools
```

## Analyze your stats and benchmark them with other users' submissions.

The output of `analyze-history` contains a lot of informational messages (as you can see in the next block).
These informational messages can be silenced using the `--quiet` flag.

```nushell
use nu-history-tools; let $res = nu-history-tools analyze-history; $res | first 10
```

Output:

```
*******************************************************************************
                       nu-commands-frequency-stats v0.2.1
*******************************************************************************

Your history is in sqlite format and will be used for analysis. Additionally,
you have history in txt format, which consists of 496 lines. It will be used
for analysis as well.

Your stats have been saved to
/Users/user/git/nu-history-tools/stats_submissions/v2+WriteYourNick.csv.
Please consider donating them to the original repository
https://github.com/nushell-prophet/nu-history-tools/tree/main/stats_submissions
.

*******************************************************************************
                Aggregated stats of other users for benchmarks.
                   They will be displayed in the final table.
*******************************************************************************

freq_by_user (frequency norm by user) includes stats from all users. You can
pick some of them by providing the --pick_users flag: stats --pick_users or
aggregate-submissions --pick_users.

╭─#──┬──────user──────┬─command_entries─╮
│ 0  │ maximuvarov    │          120938 │
│ 1  │ vinlet         │           33817 │
│ 2  │ fdncred        │           18538 │
│ 3  │ nu_scripts     │           11214 │
│ 4  │ kubouch        │           10170 │
│ 5  │ ErichDonGubler │           10101 │
│ 6  │ chtenb         │            9376 │
│ 7  │ shinyzero0     │            9247 │
│ 8  │ dazfuller      │            7354 │
│ 9  │ cptpiepmatz    │            4199 │
│ 10 │ zjp            │            2764 │
│ 11 │ sholderbach    │            2114 │
│ 12 │ horasal        │            1373 │
│ 13 │ nu_std         │             985 │
│ 14 │ pingiun        │             894 │
│ 15 │ nicokosi       │             255 │
╰─#──┴──────user──────┴─command_entries─╯
*******************************************************************************
                                Resulting table
*******************************************************************************
A note about some columns:
- freq - indicates the overall frequency of use of the given command for the
currently analyzed source
- freq_norm - represents the overall frequency normalized
- freq_norm_bar - shows the overall frequency normalized in a bar chart format
- timeline - displays the dynamics, indicating when the command was used
throughout your history
- importance - calculated as the geometric mean of the number of users who
used this command and the average normalized frequency
- freq_by_user (frequency norm by user) - each bar in the sparkline column
represents one user (order is shown in the table above).

╭─#─┬──name──┬──category──┬─freq─┬─freq_norm─┬─freq_norm_bar─┬──timeline───┬─importance─┬─importance_b─┬───freq_by_user───╮
│ 0 │ ls     │ filesystem │ 7358 │      1.00 │ ██████████    │ ▅█▆▆▅▆▆▇▆▃▁ │       1.00 │ ████████████ │ ▇▄█▁█▃▁█▄▄█▆█▁▆▇ │
│ 1 │ get    │ filters    │ 7316 │      0.99 │ ██████████    │ ▆█▆▅▅▃▃▃▃▃▁ │       0.83 │ ██████████   │ ▇█▅▂▆▂▁▄▃▁▂▃▂▃▂█ │
│ 2 │ open   │ filesystem │ 6279 │      0.85 │ ████████▌     │ ▄█▅▃▃▄▄▅▅▅▁ │       0.79 │ █████████▌   │ ▆█▄▁▄▂▁▄▃▆▂▃▃▁▂▇ │
│ 3 │ let    │ core       │ 4256 │      0.58 │ █████▊        │ ▆█▅▇▅▅▃▆▅▅▁ │       0.64 │ ███████▋     │ ▅▃▄█▃▁▁▂▁▁▂▂▂▆▃▁ │
│ 4 │ each   │ filters    │ 4091 │      0.56 │ █████▌        │ ▄█▆▇▆▅▄▇█▅▁ │       0.57 │ ██████▊      │ ▅█▃▂▄▂▁▂▁▁▂▃▂▂▁▁ │
│ 5 │ where  │ filters    │ 3648 │      0.50 │ █████         │ ▄█▄▆█▇▆▇▄█▁ │       0.51 │ ██████▏      │ ▇█▅▂▅▂▁▃▃▂▂▅▃▃▁▁ │
│ 6 │ upsert │ filters    │ 2822 │      0.38 │ ███▉          │ ▅▅▄▄█▄▂▁▁▁▁ │       0.17 │ ██           │ █▅▃▂▁▁▁▁▁▁▁▁▁▁▁▁ │
│ 7 │ first  │ filters    │ 2404 │      0.33 │ ███▎          │ ▄█▅▃▅▃▃▃▃▂▁ │       0.27 │ ███▎         │ █▁▄▂▁▂▁▁▂▄▃▃▁▁▁▁ │
│ 8 │ polars │ dataframe  │ 2303 │      0.31 │ ███▏          │ ▁▁▁▁▁▁▁█▄▁▁ │       0.05 │ ▌            │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ 9 │ lines  │ filters    │ 2041 │      0.28 │ ██▊           │ ▂▄▄▃▄▃▅▄▃█▁ │       0.45 │ █████▍       │ ██▆▂▆█▁▇▁▅▇▆▃▁▁▁ │
╰─#─┴──name──┴──category──┴─freq─┴─freq_norm─┴─freq_norm_bar─┴──timeline───┴─importance─┴─importance_b─┴───freq_by_user───╯
```

## Analyze submissions separately

```nushell
> use nu-history-tools; let $res2 = nu-history-tools aggregate-submissions --quiet; $res2 | first 5
╭─#─┬─name─┬──category──┬─freq_overall─┬─users_count─┬─f_n_per_user─┬───freq_by_user───┬─importance─┬─importance_b─╮
│ 0 │ ls   │ filesystem │        15045 │          14 │         0.62 │ ▇▄█▁█▃▁█▄▄█▆█▁▆▇ │       1.00 │ ████████████ │
│ 1 │ cd   │ filesystem │         8492 │          15 │         0.43 │ ▂▃▄▁▇▃▂▁██▇▄▄▁█▁ │       0.87 │ ██████████▍  │
│ 2 │ get  │ filters    │        13710 │          16 │         0.37 │ ▇█▅▂▆▂▁▄▃▁▂▃▂▃▂█ │       0.83 │ ██████████   │
│ 3 │ open │ filesystem │        12561 │          15 │         0.36 │ ▆█▄▁▄▂▁▄▃▆▂▃▃▁▂▇ │       0.79 │ █████████▌   │
│ 4 │ help │ core       │         3397 │          14 │         0.29 │ ▂▂▅▁▃▁▁▂▂▂▃█▁▁▇█ │       0.69 │ ████████▎    │
╰─#─┴─name─┴──category──┴─freq_overall─┴─users_count─┴─f_n_per_user─┴───freq_by_user───┴─importance─┴─importance_b─╯
```

## The most frequent Nushell commands in the current submissions

*The full data you can find in this [csv file](https://github.com/nushell-prophet/nu-history-tools/tree/main/assets/script_results_examples/aggregated-submissions.csv).*


```
╭──#──┬────────name────────┬───category───┬─importance─┬─importance_b─╮
│ 0   │ ls                 │ filesystem   │       1.00 │ ████████████ │
│ 1   │ cd                 │ filesystem   │       0.87 │ ██████████▍  │
│ 2   │ get                │ filters      │       0.83 │ ██████████   │
│ 3   │ open               │ filesystem   │       0.79 │ █████████▌   │
│ 4   │ help               │ core         │       0.69 │ ████████▎    │
│ 5   │ let                │ core         │       0.64 │ ███████▋     │
│ 6   │ each               │ filters      │       0.57 │ ██████▊      │
│ 7   │ config             │ env          │       0.51 │ ██████▏      │
│ 8   │ where              │ filters      │       0.51 │ ██████▏      │
│ 9   │ lines              │ filters      │       0.45 │ █████▍       │
│ 10  │ rm                 │ filesystem   │       0.42 │ █████        │
│ 11  │ source             │ core         │       0.41 │ ████▉        │
│ 12  │ echo               │ core         │       0.40 │ ████▊        │
│ 13  │ if                 │ core         │       0.38 │ ████▌        │
│ 14  │ find               │ filters      │       0.33 │ ███▉         │
│ 15  │ print              │ strings      │       0.32 │ ███▉         │
│ 16  │ table              │ viewers      │       0.31 │ ███▊         │
│ 17  │ ansi               │ platform     │       0.30 │ ███▋         │
│ 18  │ sort-by            │ filters      │       0.30 │ ███▋         │
│ 19  │ exit               │ shells       │       0.29 │ ███▌         │
│ 20  │ update             │ filters      │       0.29 │ ███▍         │
│ 21  │ def                │ core         │       0.29 │ ███▌         │
│ 22  │ select             │ filters      │       0.29 │ ███▍         │
│ 23  │ debug              │ debug        │       0.28 │ ███▍         │
│ 24  │ do                 │ core         │       0.27 │ ███▎         │
│ 25  │ which              │ system       │       0.27 │ ███▎         │
│ 26  │ save               │ filesystem   │       0.27 │ ███▎         │
│ 27  │ from json          │ formats      │       0.27 │ ███▎         │
│ 28  │ first              │ filters      │       0.27 │ ███▎         │
│ 29  │ str join           │ strings      │       0.26 │ ███▏         │
│ 30  │ flatten            │ filters      │       0.24 │ ██▉          │
│ 31  │ length             │ filters      │       0.23 │ ██▊          │
│ 32  │ use                │ core         │       0.23 │ ██▊          │
│ 33  │ sys                │ system       │       0.22 │ ██▋          │
│ 34  │ to text            │ formats      │       0.22 │ ██▋          │
│ 35  │ version            │ core         │       0.22 │ ██▊          │
│ 36  │ all                │ filters      │       0.21 │ ██▌          │
│ 37  │ let-env            │ removed      │       0.21 │ ██▌          │
│ 38  │ describe           │ core         │       0.21 │ ██▌          │
│ 39  │ transpose          │ filters      │       0.21 │ ██▋          │
│ 40  │ is-empty           │ filters      │       0.20 │ ██▍          │
│ 41  │ ps                 │ system       │       0.20 │ ██▍          │
│ 42  │ parse              │ strings      │       0.20 │ ██▍          │
│ 43  │ str replace        │ strings      │       0.20 │ ██▍          │
│ 44  │ mkdir              │ filesystem   │       0.19 │ ██▎          │
│ 45  │ mv                 │ filesystem   │       0.19 │ ██▍          │
│ 46  │ char               │ strings      │       0.19 │ ██▎          │
│ 47  │ last               │ filters      │       0.19 │ ██▎          │
│ 48  │ http get           │ network      │       0.18 │ ██▎          │
│ 49  │ from               │ formats      │       0.17 │ ██           │
│ 50  │ upsert             │ filters      │       0.17 │ ██           │
│ 51  │ for                │ core         │       0.16 │ █▉           │
│ 52  │ export def         │ core         │       0.16 │ █▉           │
│ 53  │ default            │ filters      │       0.16 │ █▉           │
│ 54  │ split row          │ strings      │       0.16 │ ██           │
│ 55  │ any                │ filters      │       0.15 │ █▊           │
│ 56  │ encode             │ strings      │       0.15 │ █▊           │
│ 57  │ metadata           │ debug        │       0.15 │ █▊           │
│ 58  │ try                │ core         │       0.15 │ █▊           │
│ 59  │ filter             │ filters      │       0.15 │ █▉           │
│ 60  │ complete           │ system       │       0.15 │ █▊           │
│ 61  │ merge              │ filters      │       0.15 │ █▉           │
│ 62  │ append             │ filters      │       0.15 │ █▉           │
│ 63  │ history            │ history      │       0.15 │ █▉           │
│ 64  │ help commands      │ core         │       0.14 │ █▋           │
│ 65  │ skip               │ filters      │       0.14 │ █▋           │
│ 66  │ clear              │ platform     │       0.14 │ █▊           │
│ 67  │ timeit             │ debug        │       0.14 │ █▋           │
│ 68  │ insert             │ filters      │       0.14 │ █▋           │
│ 69  │ into int           │ conversions  │       0.14 │ █▊           │
│ 70  │ take               │ filters      │       0.13 │ █▋           │
│ 71  │ explore            │ viewers      │       0.13 │ █▌           │
│ 72  │ to json            │ formats      │       0.13 │ █▋           │
│ 73  │ cp                 │ filesystem   │       0.13 │ █▌           │
│ 74  │ str trim           │ strings      │       0.13 │ █▌           │
│ 75  │ group-by           │ filters      │       0.13 │ █▋           │
│ 76  │ rename             │ filters      │       0.13 │ █▋           │
│ 77  │ reject             │ filters      │       0.13 │ █▌           │
│ 78  │ mut                │ core         │       0.12 │ █▍           │
│ 79  │ columns            │ filters      │       0.12 │ █▍           │
│ 80  │ uniq               │ filters      │       0.12 │ █▌           │
│ 81  │ date now           │ date         │       0.12 │ █▌           │
│ 82  │ overlay            │ core         │       0.11 │ █▍           │
│ 83  │ decode             │ strings      │       0.11 │ █▍           │
│ 84  │ input              │ platform     │       0.11 │ █▍           │
│ 85  │ into               │ conversions  │       0.11 │ █▍           │
│ 86  │ from csv           │ formats      │       0.11 │ █▍           │
│ 87  │ to                 │ formats      │       0.11 │ █▎           │
│ 88  │ path expand        │ path         │       0.11 │ █▍           │
│ 89  │ fill               │ conversions  │       0.11 │ █▍           │
│ 90  │ fmt                │ conversions  │       0.10 │ █▏           │
│ 91  │ error make         │ core         │       0.10 │ █▎           │
│ 92  │ prepend            │ filters      │       0.10 │ █▎           │
│ 93  │ path join          │ path         │       0.10 │ █▎           │
│ 94  │ into datetime      │ conversions  │       0.10 │ █▏           │
│ 95  │ str substring      │ strings      │       0.10 │ █▏           │
│ 96  │ run-external       │ system       │       0.09 │ █▏           │
│ 97  │ ignore             │ core         │       0.09 │ █▏           │
│ 98  │ from tsv           │ formats      │       0.09 │ █▏           │
│ 99  │ start              │ filesystem   │       0.09 │ █            │
│ 100 │ to nuon            │ formats      │       0.09 │ █▏           │
│ 101 │ reverse            │ filters      │       0.09 │ █▏           │
│ 102 │ reduce             │ filters      │       0.09 │ █▏           │
│ 103 │ glob               │ filesystem   │       0.09 │ █▏           │
│ 104 │ alias              │ core         │       0.08 │ █            │
│ 105 │ split column       │ strings      │       0.08 │ ▉            │
│ 106 │ str starts-with    │ strings      │       0.08 │ █            │
│ 107 │ commandline        │ core         │       0.08 │ █            │
│ 108 │ into record        │ conversions  │       0.08 │ █            │
│ 109 │ sleep              │ platform     │       0.08 │ █            │
│ 110 │ path parse         │ path         │       0.08 │ █            │
│ 111 │ drop               │ filters      │       0.08 │ █            │
│ 112 │ from xml           │ formats      │       0.07 │ ▊            │
│ 113 │ du                 │ filesystem   │       0.07 │ ▉            │
│ 114 │ return             │ core         │       0.07 │ ▊            │
│ 115 │ format             │ strings      │       0.07 │ ▉            │
│ 116 │ str contains       │ strings      │       0.07 │ ▉            │
│ 117 │ into binary        │ conversions  │       0.07 │ ▉            │
│ 118 │ zip                │ filters      │       0.07 │ ▉            │
│ 119 │ items              │ filters      │       0.07 │ ▊            │
│ 120 │ seq                │ generators   │       0.07 │ ▊            │
│ 121 │ into string        │ conversions  │       0.07 │ ▉            │
│ 122 │ enumerate          │ filters      │       0.07 │ ▉            │
│ 123 │ term size          │ platform     │       0.07 │ ▊            │
│ 124 │ config nu          │ env          │       0.07 │ ▉            │
│ 125 │ view               │ debug        │       0.06 │ ▋            │
│ 126 │ exec               │ system       │       0.06 │ ▊            │
│ 127 │ from nuon          │ formats      │       0.06 │ ▊            │
│ 128 │ collect            │ filters      │       0.06 │ ▋            │
│ 129 │ to md              │ formats      │       0.06 │ ▊            │
│ 130 │ str length         │ strings      │       0.06 │ ▊            │
│ 131 │ split chars        │ strings      │       0.06 │ ▊            │
│ 132 │ sort               │ filters      │       0.06 │ ▊            │
│ 133 │ math sum           │ math         │       0.06 │ ▊            │
│ 134 │ values             │ filters      │       0.06 │ ▊            │
│ 135 │ format date        │ strings      │       0.06 │ ▋            │
│ 136 │ wrap               │ filters      │       0.06 │ ▊            │
│ 137 │ overlay use        │ core         │       0.06 │ ▊            │
│ 138 │ const              │ core         │       0.05 │ ▋            │
│ 139 │ export             │ core         │       0.05 │ ▋            │
│ 140 │ module             │ core         │       0.05 │ ▋            │
│ 141 │ math avg           │ math         │       0.05 │ ▋            │
│ 142 │ into duration      │ conversions  │       0.05 │ ▋            │
│ 143 │ match              │ core         │       0.05 │ ▋            │
│ 144 │ path split         │ path         │       0.05 │ ▋            │
│ 145 │ to csv             │ formats      │       0.05 │ ▋            │
│ 146 │ nu-highlight       │ strings      │       0.05 │ ▋            │
│ 147 │ view source        │ debug        │       0.05 │ ▋            │
│ 148 │ par-each           │ filters      │       0.05 │ ▋            │
│ 149 │ to yaml            │ formats      │       0.05 │ ▌            │
│ 150 │ polars             │ dataframe    │       0.05 │ ▌            │
│ 151 │ export module      │ core         │       0.04 │ ▌            │
│ 152 │ loop               │ core         │       0.04 │ ▌            │
│ 153 │ from ssv           │ formats      │       0.04 │ ▌            │
│ 154 │ while              │ core         │       0.04 │ ▌            │
│ 155 │ keybindings        │ platform     │       0.04 │ ▍            │
│ 156 │ group              │ filters      │       0.04 │ ▌            │
│ 157 │ histogram          │ chart        │       0.04 │ ▌            │
│ 158 │ path dirname       │ path         │       0.04 │ ▌            │
│ 159 │ path relative-to   │ path         │       0.04 │ ▍            │
│ 160 │ touch              │ filesystem   │       0.04 │ ▍            │
│ 161 │ overlay list       │ core         │       0.04 │ ▌            │
│ 162 │ str                │ strings      │       0.04 │ ▌            │
│ 163 │ date format        │ removed      │       0.04 │ ▌            │
│ 164 │ scope commands     │ core         │       0.04 │ ▌            │
│ 165 │ path exists        │ path         │       0.04 │ ▌            │
│ 166 │ inspect            │ debug        │       0.04 │ ▌            │
│ 167 │ window             │ filters      │       0.04 │ ▌            │
│ 168 │ path basename      │ path         │       0.04 │ ▌            │
│ 169 │ ansi strip         │ platform     │       0.04 │ ▌            │
│ 170 │ join               │ filters      │       0.04 │ ▌            │
│ 171 │ from yaml          │ formats      │       0.04 │ ▍            │
│ 172 │ break              │ core         │       0.03 │ ▍            │
│ 173 │ with-env           │ env          │       0.03 │ ▍            │
│ 174 │ schema             │ database     │       0.03 │ ▍            │
│ 175 │ date               │ date         │       0.03 │ ▍            │
│ 176 │ detect columns     │ strings      │       0.03 │ ▍            │
│ 177 │ tutor              │ misc         │       0.03 │ ▎            │
│ 178 │ hide               │ core         │       0.03 │ ▍            │
│ 179 │ each while         │ filters      │       0.03 │ ▍            │
│ 180 │ math abs           │ math         │       0.03 │ ▍            │
│ 181 │ export-env         │ env          │       0.03 │ ▍            │
│ 182 │ path type          │ path         │       0.03 │ ▍            │
│ 183 │ keybindings listen │ platform     │       0.03 │ ▍            │
│ 184 │ to tsv             │ formats      │       0.03 │ ▍            │
│ 185 │ move               │ filters      │       0.03 │ ▍            │
│ 186 │ config env         │ env          │       0.03 │ ▎            │
│ 187 │ into float         │ conversions  │       0.03 │ ▎            │
│ 188 │ skip until         │ filters      │       0.03 │ ▍            │
│ 189 │ scope              │ core         │       0.02 │ ▎            │
│ 190 │ str downcase       │ strings      │       0.02 │ ▎            │
│ 191 │ load-env           │ filesystem   │       0.02 │ ▎            │
│ 192 │ take while         │ filters      │       0.02 │ ▎            │
│ 193 │ regex              │ experimental │       0.02 │ ▎            │
│ 194 │ split words        │ strings      │       0.02 │ ▏            │
│ 195 │ date to-timezone   │ date         │       0.02 │ ▎            │
│ 196 │ decode base64      │ hash         │       0.02 │ ▎            │
│ 197 │ date to-record     │ date         │       0.02 │ ▎            │
│ 198 │ is-not-empty       │ filters      │       0.02 │ ▎            │
│ 199 │ view files         │ debug        │       0.02 │ ▎            │
╰──#──┴────────name────────┴───category───┴─importance─┴─importance_b─╯
```
