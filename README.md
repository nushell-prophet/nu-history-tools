<h1 align="center">nu-history-tools</h1>
<h3 align="center">Nushell🚀 module for commands history analytics</h3>

A Nushell module to analyze the command frequencies in Nushell history, generate cool graphs, benchmark statistics with other users, and generate a file with statistics to share with the community.

Aggregated results, produced by the `aggregate-submissions` command can be found in the [csv file](https://github.com/nushell-prophet/nu-history-tools/tree/main/script_results/aggregated-submissions.csv)

The history of nushell commands by releases can be found in [this csv](https://github.com/nushell-prophet/nu-history-tools/blob/main/crates_parsing/cmds_by_crates_and_tags.csv)

![nu-history-tools2](https://github.com/nushell-prophet/nu-history-tools/assets/4896754/5053ede0-d53a-46be-bd71-7f066eca7025)

## Installation

```nushell no-run
> git clone https://github.com/nushell-prophet/nu-history-tools; cd nu-history-tools
```

## Analyze your stats and benchmark them with other users' submissions.

```nushell
> overlay use nu-history-tools.nu; let $res = nu-hist-stats; $res | first 10
*******************************************************************************
                        nu-commands-frequency-stats v2.0
*******************************************************************************

Your history is in sqlite format and will be used for analysis. Additionally,
you have history in txt format, which consists of 489 entries. It will be
used for analysis as well.

The script is calculating stats now. On an M1 Mac with a history of ~50,000
entries, It runs for about a minute. Please wait

Your stats have been saved to
/Users/user/git/nu-stats/stats_submissions/v2+WriteYourNick.csv. Please
consider donating them to the original repository
https://github.com/nushell-prophet/nu-history-tools/tree/main/stats_submissions
.

*******************************************************************************
                Aggregated stats of other users for benchmarks.
                   They will be displayed in the final table.
*******************************************************************************

freq_by_user (frequency norm by user) includes stats from all users. You can
pick some of them by providing the --pick_users flag: nu-hist-stats
--pick_users or aggregate-submissions --pick_users.

╭─#──┬──────user──────┬─command_entries─╮
│ 0  │ maximuvarov    │       136961.00 │
│ 1  │ vinlet         │        33817.00 │
│ 2  │ fdncred        │        18500.00 │
│ 3  │ kubouch        │        10170.00 │
│ 4  │ ErichDonGubler │        10101.00 │
│ 5  │ chtenb         │         9376.00 │
│ 6  │ shinyzero0     │         9247.00 │
│ 7  │ nu_scripts     │         8622.00 │
│ 8  │ dazfuller      │         7354.00 │
│ 9  │ cptpiepmatz    │         4199.00 │
│ 10 │ zjp            │         2764.00 │
│ 11 │ sholderbach    │         2114.00 │
│ 12 │ horasal        │         1373.00 │
│ 13 │ nu_std         │         1202.00 │
│ 14 │ pingiun        │          894.00 │
│ 15 │ nicokosi       │          255.00 │
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

╭─#─┬──name──┬─category─┬─freq──┬─freq_norm─┬─freq_norm_bar─┬───────────────────────────timeline───────────────────────────┬─importance─┬─importance_b─┬───freq_by_user───╮
│ 0 │ dfr    │          │ 10970 │      1.00 │ ██████████    │ ▁▁▁▁▁▁▁▃▂▃▅▇▄▂█▆▃▁▂▃▃▂▃▂▁▂▃▁▂▁▂▄▂▂▃▄▃▂▆▁▂▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │       0.12 │ █▍           │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ 1 │ get    │          │  8178 │      0.75 │ ███████▌      │ ▂▂▃▄▃▆▄▄█▃▄▃▅▅▂▂▃▄▂▄▂▂▂▄▃▃▂▂▄▃▂▂▃▁▂▂▂▂▂▃▂▂▃▂▂▂▂▁▂▂▁▃▂▃▂▃▂▂▄▁ │       0.80 │ █████████▋   │ ▆█▅▆▂▁▄▂▃▁▂▃▂▃▂█ │
│ 2 │ ls     │          │  7720 │      0.70 │ ███████       │ ▃▃▃▂▃▂▃▅█▅▃▃▅▃▄▄▄▂▃▆▄▂▂▃▃▄▄▂▃▄▅▃▃▁▃▅▃▄▃▃▄▃▃▃▅▅▃▃▃▄▄▃▃▄▂▃▂▂▂▁ │       1.00 │ ████████████ │ ▆▄██▃▁█▁▄▄█▆█▁▆▇ │
│ 3 │ open   │          │  6935 │      0.63 │ ██████▍       │ ▂▂▃▃▃▄▃▆█▄▃▂▅▆▂▂▂▃▂▃▂▂▂▂▂▂▂▁▃▂▃▄▂▁▂▅▃▃▂▃▂▂▃▄▂▅▃▂▂▃▂▅▅▃▅▄▃▂▂▁ │       0.79 │ █████████▌   │ ▅█▄▄▂▁▄▁▃▆▂▃▃▁▂▇ │
│ 4 │ let    │ core     │  4778 │      0.44 │ ████▍         │ ▂▂▃▄▅▅▃▃▃▅▅▅▄▂▃▃▃▂▂▄▂▂▄█▅▃▃▂▂▂▅▃▃▁▃▂▂▂▂▂▂▂▂▃▃▄▄▃▆▃▁▁▄▂▁▂▁▄▆▁ │       0.62 │ ███████▍     │ ▄▃▄▃▁▁▂█▁▁▂▂▂▆▃▁ │
│ 5 │ each   │          │  4490 │      0.41 │ ████▏         │ ▂▂▂▂▂▃▃▃▅▃▂▃▃█▁▁▁▂▃▅▂▃▃▄▂▂▃▂▃▂▄▂▃▁▃▃▂▂▂▃▂▂▂▃▄▃▃▃▂▃▇▃▄▂▃▄▂▂▂▁ │       0.54 │ ██████▌      │ ▄█▃▄▂▁▂▂▁▁▂▃▂▂▁▁ │
│ 6 │ nu     │          │  4056 │      0.37 │ ███▊          │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▂▁▁▂▁▁▁▁▁▂▁▁▂▄▃█▆▃▃▅▅▃▃▂▄▅▄▄▇▅▂▂▅▁ │       0.05 │ ▋            │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ 7 │ where  │ filters  │  3907 │      0.36 │ ███▌          │ ▂▂▂▁▃▃▅█▇▃▃▁▄▄▂▁▃▁▂▃▃▂▃▅▇▃▃▃▆▄▆▅▄▁▃▅▃▃▃▇▄▂▃▇▅▂▂▂▂▃▃▃▂▂▃█▇▃▂▁ │       0.49 │ █████▉       │ ▆█▅▅▂▁▃▂▃▂▂▅▃▃▁▁ │
│ 8 │ upsert │          │  3275 │      0.30 │ ███           │ ▂▂▁▃▃█▂▃▅▅▃▂▂▅▂▁▄▁▂▂▂▁▅▆▆▃▇▆▅▄▃▅▅▁▂▁▂▂▁▂▂▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁ │       0.16 │ ██           │ █▅▃▁▁▁▁▂▁▁▁▁▁▁▁▁ │
│ 9 │ polars │          │  2797 │      0.25 │ ██▌           │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▆▄▄▄▇█▆▂▃▅▃▁▁▁▁▁▂▁ │       0.04 │ ▌            │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
╰─#─┴──name──┴─category─┴─freq──┴─freq_norm─┴─freq_norm_bar─┴───────────────────────────timeline───────────────────────────┴─importance─┴─importance_b─┴───freq_by_user───╯
```

## Analyze submissions separately

```nushell
> use nu-history-tools.nu aggregate-submissions; let $res2 = (aggregate-submissions); $res2 | first 5
*******************************************************************************
                Aggregated stats of other users for benchmarks.
                   They will be displayed in the final table.
*******************************************************************************

freq_by_user (frequency norm by user) includes stats from all users. You can
pick some of them by providing the --pick_users flag: nu-hist-stats
--pick_users or aggregate-submissions --pick_users.

╭─#──┬──────user──────┬─command_entries─╮
│ 0  │ maximuvarov    │       136961.00 │
│ 1  │ vinlet         │        33817.00 │
│ 2  │ fdncred        │        18500.00 │
│ 3  │ kubouch        │        10170.00 │
│ 4  │ ErichDonGubler │        10101.00 │
│ 5  │ chtenb         │         9376.00 │
│ 6  │ shinyzero0     │         9247.00 │
│ 7  │ nu_scripts     │         8622.00 │
│ 8  │ dazfuller      │         7354.00 │
│ 9  │ cptpiepmatz    │         4199.00 │
│ 10 │ zjp            │         2764.00 │
│ 11 │ sholderbach    │         2114.00 │
│ 12 │ horasal        │         1373.00 │
│ 13 │ nu_std         │         1202.00 │
│ 14 │ pingiun        │          894.00 │
│ 15 │ nicokosi       │          255.00 │
╰─#──┴──────user──────┴─command_entries─╯
╭─#─┬─name─┬─category─┬─freq_overall─┬─users_count─┬─f_n_per_user─┬───freq_by_user───┬─importance─┬─importance_b─┬───crate────┬─first_tag─┬─last_tag─╮
│ 0 │ ls   │          │     15402.00 │          15 │         0.61 │ ▆▄██▃▁█▁▄▄█▆█▁▆▇ │       1.00 │ ████████████ │ nu-parser  │ 0.2.0     │ 0.97.1   │
│ 1 │ cd   │          │      8572.00 │          15 │         0.43 │ ▂▃▄▇▃▂▁▁██▇▄▄▁█▁ │       0.84 │ ██████████▏  │ nu-command │ 0.2.0     │ 0.97.1   │
│ 2 │ get  │          │        14486 │          16 │         0.36 │ ▆█▅▆▂▁▄▂▃▁▂▃▂▃▂█ │       0.80 │ █████████▋   │ nu-command │ 0.2.0     │ 0.97.1   │
│ 3 │ open │          │        13221 │          16 │         0.36 │ ▅█▄▄▂▁▄▁▃▆▂▃▃▁▂▇ │       0.79 │ █████████▌   │ nu-command │ 0.2.0     │ 0.97.1   │
│ 4 │ help │          │      3485.00 │          14 │         0.29 │ ▂▂▅▃▁▁▂▁▂▂▃█▁▁▇█ │       0.67 │ ████████▏    │ nu-command │ 0.3.0     │ 0.97.1   │
╰─#─┴─name─┴─category─┴─freq_overall─┴─users_count─┴─f_n_per_user─┴───freq_by_user───┴─importance─┴─importance_b─┴───crate────┴─first_tag─┴─last_tag─╯

> use nu-history-tools.nu [aggregate-submissions]; let $res = aggregate-submissions; $res | first 10
*******************************************************************************
                Aggregated stats of other users for benchmarks.
                   They will be displayed in the final table.
*******************************************************************************

freq_by_user (frequency norm by user) includes stats from all users. You can
pick some of them by providing the --pick_users flag: nu-hist-stats
--pick_users or aggregate-submissions --pick_users.

╭─#──┬──────user──────┬─command_entries─╮
│ 0  │ maximuvarov    │       136961.00 │
│ 1  │ vinlet         │        33817.00 │
│ 2  │ fdncred        │        18500.00 │
│ 3  │ kubouch        │        10170.00 │
│ 4  │ ErichDonGubler │        10101.00 │
│ 5  │ chtenb         │         9376.00 │
│ 6  │ shinyzero0     │         9247.00 │
│ 7  │ nu_scripts     │         8622.00 │
│ 8  │ dazfuller      │         7354.00 │
│ 9  │ cptpiepmatz    │         4199.00 │
│ 10 │ zjp            │         2764.00 │
│ 11 │ sholderbach    │         2114.00 │
│ 12 │ horasal        │         1373.00 │
│ 13 │ nu_std         │         1202.00 │
│ 14 │ pingiun        │          894.00 │
│ 15 │ nicokosi       │          255.00 │
╰─#──┴──────user──────┴─command_entries─╯
╭─#─┬──name──┬─category─┬─freq_overall─┬─users_count─┬─f_n_per_user─┬───freq_by_user───┬─importance─┬─importance_b─┬───crate────┬─first_tag─┬─last_tag─╮
│ 0 │ ls     │          │     15402.00 │          15 │         0.61 │ ▆▄██▃▁█▁▄▄█▆█▁▆▇ │       1.00 │ ████████████ │ nu-parser  │ 0.2.0     │ 0.97.1   │
│ 1 │ cd     │          │      8572.00 │          15 │         0.43 │ ▂▃▄▇▃▂▁▁██▇▄▄▁█▁ │       0.84 │ ██████████▏  │ nu-command │ 0.2.0     │ 0.97.1   │
│ 2 │ get    │          │        14486 │          16 │         0.36 │ ▆█▅▆▂▁▄▂▃▁▂▃▂▃▂█ │       0.80 │ █████████▋   │ nu-command │ 0.2.0     │ 0.97.1   │
│ 3 │ open   │          │        13221 │          16 │         0.36 │ ▅█▄▄▂▁▄▁▃▆▂▃▃▁▂▇ │       0.79 │ █████████▌   │ nu-command │ 0.2.0     │ 0.97.1   │
│ 4 │ help   │          │      3485.00 │          14 │         0.29 │ ▂▂▅▃▁▁▂▁▂▂▃█▁▁▇█ │       0.67 │ ████████▏    │ nu-command │ 0.3.0     │ 0.97.1   │
│ 5 │ let    │ core     │      8862.00 │          14 │         0.25 │ ▄▃▄▃▁▁▂█▁▁▂▂▂▆▃▁ │       0.62 │ ███████▍     │ nu-parser  │ 0.25.0    │ 0.97.1   │
│ 6 │ each   │          │      9223.00 │          14 │         0.19 │ ▄█▃▄▂▁▂▂▁▁▂▃▂▂▁▁ │       0.54 │ ██████▌      │ nu-command │ 0.13.0    │ 0.97.1   │
│ 7 │ config │          │      1593.00 │          14 │         0.16 │ ▁▁▃█▁▁▅▁▁▂▆▂▂▁▆▅ │       0.50 │ ██████       │ nu-command │ 0.2.0     │ 0.97.1   │
│ 8 │ where  │ filters  │      7346.00 │          13 │         0.17 │ ▆█▅▅▂▁▃▂▃▂▂▅▃▃▁▁ │       0.49 │ █████▉       │ nu-command │ 0.2.0     │ 0.97.1   │
│ 9 │ lines  │          │      4676.00 │          14 │         0.12 │ ▇█▆▆█▁▇▂▁▅▇▆▃▂▁▁ │       0.43 │ █████▎       │ nu-command │ 0.2.0     │ 0.97.1   │
╰─#─┴──name──┴─category─┴─freq_overall─┴─users_count─┴─f_n_per_user─┴───freq_by_user───┴─importance─┴─importance_b─┴───crate────┴─first_tag─┴─last_tag─╯
```
