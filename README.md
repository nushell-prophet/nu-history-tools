# nu-commands-frequency-stats

## Installation

```sh
> git clone https://github.com/maxim-uvarov/nu-commands-frequency-stats; cd nu-commands-frequency-stats
```

## Analyze your stats and benchmark them with other users' submissions.

```sh
> use v2-nu-commands-freq.nu nu-hist-stats; let $res1 = (nu-hist-stats); $res1
The script is working with your history. On an M1 Mac with a history of ~40,000 entries, it runs for about a minute.

A note about some columns:
- timeline - represents dynamics, showing when the command was used throughout your history
- users_c_rank - is the geometric mean of the number of users who used this command and average_norm_frequency
- users_sparkline - each bar in the sparkline column represents 1 user.

- users_sparkline is ordered by sum of executed commands:
╭─#──┬──────user──────┬executions_total╮
│ 0  │ nu_scripts     │          61840 │
│ 1  │ maximuvarov    │          26526 │
│ 2  │ fdncred        │          17258 │
│ *  | *              | *              │
│ 12 │ nu_std         │           1139 │
│ 13 │ pingiun        │            884 │
│ 14 │ nicokosi       │            255 │
╰────┴────────────────┴────────────────╯

users_c_rank is the normalized geometric mean of users_count and users_freq_norm_avg.
╭──name──┬─category─┬─freq─┬─freq_norm─┬─freq_norm_bar─┬─────timeline──────┬─users_c_rank─┬─users_c_rank_bar─┬─users_sparkline──╮
│ alias  │ core     │   27 │      0.01 │               │ ▆▃▁▂▁▁▁▁▁▁▂▁▁▂▁█▁ │         0.10 │ █▋               │ ▃▂▂▆█▁▁▁▁▁▁▁▁▃▁▁ │
│        │          │      │           │               │ ▁▁▁▁▁▁▁           │              │                  │                  │
│ all    │ filters  │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.28 │ ████▌            │ ▁▁▂▂█▁▂▂▆▁▂▅▁▁▁▁ │
│        │          │      │           │               │ ▁▁▁▁▁█▁           │              │                  │                  │
│ ansi   │ platform │  457 │      0.10 │ █             │ ▁▁▅█▁▁▁▁▁▁▁▂▃▁▁▃▂ │         0.34 │ █████▍           │ ▃▂▂▂▁▁▁▁▁▁▁▂▁█▁▁ │
│        │          │      │           │               │ ▁▃▁▁▁▂▂           │              │                  │                  │
│ *      │ *        │ *    │ *         │ *             │ *                 │ *            │ *                │ *                │
│ window │ filters  │   41 │      0.01 │ ▏             │ ▂▁▆▂▁▁▁▁█▂▂▁▁▁▁▁▂ │         0.09 │ █▍               │ ▃▃█▆▁▆▁▁▁▁▁▁▁▁▁▁ │
│        │          │      │           │               │ ▄▁▁▁▂▁▃           │              │                  │                  │
│ wrap   │ filters  │  166 │      0.04 │ ▍             │ ▄█▁▅▇▅▂▆▁▁▁▁▃▁▁▁▁ │         0.12 │ █▉               │ ▆▆█▆▁▃▁▁▁▁▁▁▁▁▁▁ │
│        │          │      │           │               │ ▁▁▆▄▁▁▃           │              │                  │                  │
│ zip    │ filters  │   14 │      0.00 │               │ ▅▄▅▁▁▁▂▁▁▁▁▁█▁▁▁▁ │         0.10 │ █▋               │ ▂▂█▇▆▅▁▇▁▁▁▁▁▄▁▁ │
│        │          │      │           │               │ ▁▁▁▁▁▁▁           │              │                  │                  │
╰────────┴──────────┴──────┴───────────┴───────────────┴───────────────────┴──────────────┴──────────────────┴──────────────────╯


```

## Analyse submissions separately
```sh
> use v2-nu-commands-freq.nu aggregate-submissions; let $res2 = (aggregate-submissions); $res2

- users_sparkline is ordered by sum of executed commands:
╭─#──┬──────user──────┬executions_total╮
│ 0  │ nu_scripts     │          61840 │
│ 1  │ maximuvarov    │          26526 │
│ 2  │ fdncred        │          17258 │
│ *  | *              | *              │
│ 12 │ nu_std         │           1139 │
│ 13 │ pingiun        │            884 │
│ 14 │ nicokosi       │            255 │
╰────┴────────────────┴────────────────╯

users_c_rank is the normalized geometric mean of users_count and users_freq_norm_avg.
╭─────name──────┬──category──┬users_count┬users_freq_norm_avg┬─users_sparkline──┬users_c_rank┬─users_c_rank_bar─╮
│ ls            │ filesystem │        15 │              0.76 │ ▆▆▆███▄▄██▁▆█▁▆▇ │       1.00 │ ████████████████ │
│ cd            │ filesystem │        15 │              0.53 │ ▂▂▃▄▇▁██▃▇█▄▄▁█▁ │       0.83 │ █████████████▎   │
│ get           │ filters    │        16 │              0.43 │ ███▅▆▄▃▁▁▂▁▃▂▃▂█ │       0.78 │ ████████████▌    │
│ *             │ *          │ *         │ *                 │ *                │ *          │ *                │
│ random bool   │ random     │         1 │              0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │       0.00 │ ▏                │
│ math product  │ math       │         1 │              0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │       0.00 │ ▏                │
│ export extern │ core       │         1 │              0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │       0.00 │ ▏                │
╰───────────────┴────────────┴───────────┴───────────────────┴──────────────────┴────────────┴──────────────────╯

```