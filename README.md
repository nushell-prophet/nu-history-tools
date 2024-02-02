<h1 align="center">nu-stats</h1>
<h3 align="center">Nushell🚀 module for commands history analytics</h3>

A Nushell module to analyze the command frequencies in Nushell history, generate cool graphs, benchmark statistics with other users, and generate a file with statistics to share with the community.

Aggregated results, produced by the `aggregate-submissions` command can be found in the [csv file](https://github.com/Nushell101/nu-stats/tree/main/script_results/aggregated-submissions.csv)

The history of nushell commands by releases can be found in [this csv](https://github.com/Nushell101/nu-stats/blob/main/crates_parsing/cmds_by_crates_and_tags.csv)

![nu-stats2](https://github.com/Nushell101/nu-stats/assets/4896754/5053ede0-d53a-46be-bd71-7f066eca7025)

## Installation

```nushell
git clone https://github.com/Nushell101/nu-stats; cd nu-stats
```

## Analyze your stats and benchmark them with other users' submissions.

```nushell
use nu-stats.nu [nu-hist-stats]; let $res = nu-hist-stats; $res
```

```numd-output
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

╭────name────┬──category──┬─freq─┬freq_norm┬freq_norm_bar┬──────────timeline───────────┬───┬importance┬─importance_b─┬──freq_by_user───╮
│ ls         │ filesystem │ 3743 │    0.73 │ ███████▎    │ ▁▄▂▁▂▁▃█▅▄▃▂▅▂▃▃▃▁▃▆▃▂▁▃▂▃▂ │ x │     1.00 │ ████████████ │ ▆▆██▁█▄▄██▆█▁▆▇ │
│ cd         │ filesystem │  854 │    0.17 │ █▋          │ ▃▆▅▅▄▂▇█▃▆▄▂▃▅▃▃▁▂▁▃▂▁▂▂▁▂▂ │ x │     0.80 │ █████████▋   │ ▂▂▄▇▂▁██▃▇▄▄▁█▁ │
│ get        │ filters    │ 5135 │       1 │ ██████████  │ ▁▂▂▃▃▅▄▄█▂▃▃▄▄▁▂▃▄▁▄▁▂▂▃▂▂▁ │ x │     0.77 │ █████████▎   │ ██▅▆▁▄▃▁▁▂▃▂▃▂█ │
│ …          │ …          │ …    │ …       │ …           │ …                           │ … │ …        │ …            │ …               │
│ vtable     │            │    0 │       0 │             │                             │ x │     0.00 │              │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ to-array   │            │    0 │       0 │             │                             │ x │     0.00 │              │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ from-array │            │    0 │       0 │             │                             │ x │     0.00 │              │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
╰────────────┴────────────┴──────┴─────────┴─────────────┴─────────────────────────────┴───┴──────────┴──────────────┴─────────────────╯
```

## Analyze submissions separately
```nushell
use v2-nu-commands-freq.nu aggregate-submissions; let $res2 = (aggregate-submissions); $res2
```
```numd-output
f_n_by_user (frequency norm by user) includes stats from all users.
You can pick some of them by providing the --pick_users flag: nu-hist-stats --pick_users or
aggregate-submissions --pick_users. The current list is:
╭─#──┬──────user──────┬executions_total╮
│ 0  │ nu_scripts     │          61840 │
│ 1  │ maximuvarov    │          26526 │
│ 2  │ fdncred        │          17258 │
│ *  | *              | *              │
│ 12 │ nu_std         │           1139 │
│ 13 │ pingiun        │            884 │
│ 14 │ nicokosi       │            255 │
╰────┴────────────────┴────────────────╯
```

```nushell
use nu-stats.nu [aggregate-submissions]; let $res = aggregate-submissions; $res
```
```numd-output
╭────name────┬──category──┬freq_overall┬users_count┬f_n_per_user┬──freq_by_user───┬importance┬─importance_b─┬───crate────┬first_tag┬last_tag╮
│ ls         │ filesystem │      13252 │        14 │       0.71 │ ▆▆██▁█▄▄██▆█▁▆▇ │     1.00 │ ████████████ │ nu-parser  │ 0.2.0   │ 0.85.0 │
│ cd         │ filesystem │       7195 │        14 │       0.45 │ ▂▂▄▇▂▁██▃▇▄▄▁█▁ │     0.80 │ █████████▋   │ nu-command │ 0.2.0   │ 0.85.0 │
│ get        │ filters    │      12474 │        15 │       0.39 │ ██▅▆▁▄▃▁▁▂▃▂▃▂█ │     0.77 │ █████████▎   │ nu-command │ 0.2.0   │ 0.85.0 │
│ …          │ …          │ …          │ …         │ …          │ …               │ …        │ …            │ …          │ …       │ …      │
│ vtable     │            │          0 │         0 │          0 │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │     0.00 │              │ commands   │ 0.2.0   │ 0.2.0  │
│ to-array   │            │          0 │         0 │          0 │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │     0.00 │              │ commands   │ 0.2.0   │ 0.2.0  │
│ from-array │            │          0 │         0 │          0 │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │     0.00 │              │ commands   │ 0.2.0   │ 0.2.0  │
╰────────────┴────────────┴────────────┴───────────┴────────────┴─────────────────┴──────────┴──────────────┴────────────┴─────────┴────────╯
```
