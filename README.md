# nu-commands-frequency-stats

## Installation

```sh
> git clone https://github.com/maxim-uvarov/nu-commands-frequency-stats; cd nu-commands-frequency-stats
```

## Analyze your stats and benchmark them with other users' submissions.

```sh
> use v2-nu-commands-freq.nu nu-hist-stats; let $res1 = (nu-hist-stats); $res1
The script is working with your history now. On an M1 Mac with a history of ~40,000 entries, it runs for about a minute.

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

importance is the normalized geometric mean of users_count and f_n_per_user.

A note about some columns:
- freq - overall frequency of use of the given command for the currently analysed source,
- freq_norm - overall frequency normalized,
- freq_norm_bar - overall frequency normalized bar,
- timeline - represents dynamics, showing when the command was used throughout your history
- importance - is the geometric mean of the number of users who used this command and average_norm_frequency
- f_n_by_user (frequency norm by user) - each bar in the sparkline column represents 1 user (order is shown in the table above).
╭─────name──────┬──category──┬─freq─┬freq_norm┬freq_norm_bar┬─────────timeline─────────┬importance┬─importance_b─┬───f_n_by_user────╮
│ ls            │ filesystem │ 3363 │    0.71 │ ███████▏    │ ▁▄▂▁▂▁▃█▅▄▃▂▅▂▃▃▃▁▃▆▃▂▁▂ │     1.00 │ ████████████ │ ▆▆▆███▄▄██▁▆█▁▆▇ │
│ cd            │ filesystem │  813 │    0.17 │ █▊          │ ▃▆▅▅▄▂▇█▃▆▄▂▃▅▃▃▁▂▁▃▂▁▂▁ │     0.83 │ ██████████   │ ▂▂▃▄▇▁██▃▇█▄▄▁█▁ │
│ get           │ filters    │ 4706 │       1 │ ██████████  │ ▁▂▂▃▃▅▄▄█▂▃▃▄▄▁▂▃▄▁▄▁▂▂▂ │     0.78 │ █████████▍   │ ███▅▆▄▃▁▁▂▁▃▂▃▂█ │
│ *             │ *          │ *    │ *       │ *           │ *                        │ *        │ *            │ *                │
│ bytes collect │ bytes      │    0 │       0 │             │                          │        0 │              │                  │
│ bytes build   │ bytes      │    0 │       0 │             │                          │        0 │              │                  │
│ bytes add     │ bytes      │    0 │       0 │             │                          │        0 │              │                  │
╰───────────────┴────────────┴──────┴─────────┴─────────────┴──────────────────────────┴──────────┴──────────────┴──────────────────╯
```

## Analyze submissions separately
```sh
> use v2-nu-commands-freq.nu aggregate-submissions; let $res2 = (aggregate-submissions); $res2

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

importance is the normalized geometric mean of users_count and f_n_per_user.
> use v2-nu-commands-freq.nu aggregate-submissions; let $res2 = (aggregate-submissions); $res2
╭─────name──────┬──category──┬freq_overall┬users_count┬f_n_per_user┬───f_n_by_user────┬importance┬─importance_b─╮
│ ls            │ filesystem │      14632 │        15 │       0.76 │ ▆▆▆███▄▄██▁▆█▁▆▇ │     1.00 │ ████████████ │
│ cd            │ filesystem │       7723 │        15 │       0.53 │ ▂▂▃▄▇▁██▃▇█▄▄▁█▁ │     0.83 │ ██████████   │
│ get           │ filters    │      14273 │        16 │       0.43 │ ███▅▆▄▃▁▁▂▁▃▂▃▂█ │     0.78 │ █████████▍   │
│ *             │ *          │ *          │ *         │ *          │ *                │ *        │ *            │
│ random bool   │ random     │          1 │         1 │       0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │     0.00 │              │
│ math product  │ math       │          1 │         1 │       0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │     0.00 │              │
│ export extern │ core       │          1 │         1 │       0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │     0.00 │              │
╰───────────────┴────────────┴────────────┴───────────┴────────────┴──────────────────┴──────────┴──────────────╯
```