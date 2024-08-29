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
> use nu-history-tools.nu; let $res = nu-history-tools stats; $res | first 10
*******************************************************************************
                        nu-commands-frequency-stats v2.0
*******************************************************************************

Your history is in sqlite format and will be used for analysis. Additionally,
you have history in txt format, which consists of 496 lines. It will be used
for analysis as well.

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
pick some of them by providing the --pick_users flag: stats --pick_users or
aggregate-submissions --pick_users.

╭─#──┬──────user──────┬─command_entries─╮
│ 0  │ maximuvarov    │          120938 │
│ 1  │ vinlet         │           33817 │
│ 2  │ fdncred        │           18538 │
│ 3  │ kubouch        │           10170 │
│ 4  │ ErichDonGubler │           10101 │
│ 5  │ chtenb         │            9376 │
│ 6  │ shinyzero0     │            9247 │
│ 7  │ nu_scripts     │            8622 │
│ 8  │ dazfuller      │            7354 │
│ 9  │ cptpiepmatz    │            4199 │
│ 10 │ zjp            │            2764 │
│ 11 │ sholderbach    │            2114 │
│ 12 │ horasal        │            1373 │
│ 13 │ nu_std         │            1202 │
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

╭─#─┬──name──┬──category──┬─freq─┬freq_norm┬freq_norm_bar┬─────────────────timeline──────────────────┬importance┬─importance_b─┬─freq_by_user─╮
│ 0 │ dfr    │            │ 8182 │    1.00 │ ██████████  │ ▁▁▁▁▁▁▃▃▇█▄▇█▃▁▂▄▃▃▂▁▄▁▂▂▅▂▁▂▆▄▄▅▂▃▁▁▁... │     0.12 │ █▍           │ █▁▁▁▁▁▁▁▁... │
│ 1 │ ls     │ filesystem │ 7355 │    0.90 │ █████████   │ ▃▄▁▃▂▄█▅▃▃▅▃▄▄▂▄▅▃▂▃▃▄▂▃▄▅▄▁▃▅▄▃▂▃▃▃▄▄... │     1.00 │ ████████████ │ ▇▄██▃▁█▁▄... │
│ 2 │ get    │ filters    │ 7325 │    0.90 │ █████████   │ ▂▄▄▄▇▆██▄▅▆▄▂▃▅▄▃▃▂▅▄▃▂▅▃▂▃▂▃▂▃▁▂▂▁▃▃▃... │     0.80 │ █████████▋   │ ▇█▅▆▂▁▄▂▃... │
│ 3 │ open   │ filesystem │ 6263 │    0.77 │ ███████▋    │ ▂▃▃▃▃▇█▅▄▃█▃▂▂▃▃▂▂▂▂▂▂▁▂▂▄▂▁▂▅▃▂▃▂▂▃▄▄... │     0.79 │ █████████▌   │ ▆█▄▄▂▁▄▁▃... │
│ 4 │ let    │ core       │ 4252 │    0.52 │ █████▎      │ ▂▃▄▅▅▄▃▅▅▅▄▃▃▃▂▃▃▂▄█▄▃▂▂▃▅▃▁▂▃▂▁▂▂▂▁▄▄... │     0.62 │ ███████▍     │ ▅▃▄▃▁▁▂█▁... │
│ 5 │ each   │ filters    │ 4077 │    0.50 │ █████       │ ▂▃▂▂▃▃▅▆▂▄▅▆▁▁▃▅▃▃▄▄▂▅▂▄▃▃▂▂▃▃▂▂▃▃▂▂▄▆... │     0.54 │ ██████▌      │ ▅█▃▄▂▁▂▂▁... │
│ 6 │ where  │ filters    │ 3641 │    0.45 │ ████▌       │ ▂▃▁▃▄▆▆▅▃▂▅▂▁▂▁▃▂▃▃▅▆▃▂▆▅▅▄▂▃▄▂▃▄▅▃▃█▄... │     0.49 │ █████▉       │ ▇█▅▅▂▁▃▂▃... │
│ 7 │ nu     │            │ 3628 │    0.44 │ ████▍       │ ▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▂▁▁▂▁▁▁▁▂▁▁▂▃██▃▅... │     0.05 │ ▋            │ █▁▁▁▁▁▁▁▁... │
│ 8 │ upsert │ filters    │ 2848 │    0.35 │ ███▌        │ ▂▂▂▅▅▃▃█▃▂▂▄▂▅▁▂▂▁▅▅▆▅█▅▄▄▄▃▂▂▂▂▂▂▂▁▁▁... │     0.17 │ ██           │ █▅▃▁▁▁▁▂▁... │
│ 9 │ first  │ filters    │ 2397 │    0.29 │ ██▉         │ ▂▄▁▃▆▄▅█▅▇▄▃▂▇▃▄▃▁▂▁▁▇▃▃▄▃▃▂▁▃▂▂▂▂▂▁▁▅... │     0.26 │ ███▏         │ █▁▄▁▂▁▁▂▂... │
╰─#─┴──name──┴──category──┴─freq─┴─freq_no─┴─freq_norm_b─┴─────────────────timeline──────────────────┴─importan─┴─importance_b─┴─freq_by_user─╯
```

## Analyze submissions separately

```nushell
> use nu-history-tools.nu; let $res2 = nu-history-tools aggregate-submissions; $res2 | first 5
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
│ 3  │ kubouch        │           10170 │
│ 4  │ ErichDonGubler │           10101 │
│ 5  │ chtenb         │            9376 │
│ 6  │ shinyzero0     │            9247 │
│ 7  │ nu_scripts     │            8622 │
│ 8  │ dazfuller      │            7354 │
│ 9  │ cptpiepmatz    │            4199 │
│ 10 │ zjp            │            2764 │
│ 11 │ sholderbach    │            2114 │
│ 12 │ horasal        │            1373 │
│ 13 │ nu_std         │            1202 │
│ 14 │ pingiun        │             894 │
│ 15 │ nicokosi       │             255 │
╰─#──┴──────user──────┴─command_entries─╯
╭─#─┬─name─┬──category──┬freq_overall┬users_count┬f_n_per_user┬───freq_by_user───┬importance┬─importance_b─┬──crate──┬first_tag┬last_tag╮
│ 0 │ ls   │ filesystem │      15029 │        15 │       0.62 │ ▇▄██▃▁█▁▄▄█▆█▁▆▇ │     1.00 │ ████████████ │ nu-p... │ 0.2.0   │ 0.97.1 │
│ 1 │ cd   │ filesystem │       8489 │        15 │       0.43 │ ▂▃▄▇▃▂▁▁██▇▄▄▁█▁ │     0.84 │ ██████████   │ nu-c... │ 0.2.0   │ 0.97.1 │
│ 2 │ get  │ filters    │      13633 │        16 │       0.37 │ ▇█▅▆▂▁▄▂▃▁▂▃▂▃▂█ │     0.80 │ █████████▋   │ nu-c... │ 0.2.0   │ 0.97.1 │
│ 3 │ open │ filesystem │      12549 │        16 │       0.36 │ ▆█▄▄▂▁▄▁▃▆▂▃▃▁▂▇ │     0.79 │ █████████▌   │ nu-c... │ 0.2.0   │ 0.97.1 │
│ 4 │ help │ core       │       3395 │        14 │       0.29 │ ▂▂▅▃▁▁▂▁▂▂▃█▁▁▇█ │     0.67 │ ████████     │ nu-c... │ 0.3.0   │ 0.97.1 │
╰─#─┴─name─┴──category──┴─freq_overa─┴─users_cou─┴─f_n_per_us─┴───freq_by_user───┴─importan─┴─importance_b─┴──crate──┴─first_t─┴─last_t─╯
```
