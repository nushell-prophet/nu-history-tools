# nu-commands-frequency-stats

```
> use v2-nu-commands-freq.nu aggregate-submissions;
> let $result = (aggregate-submissions); $result

- users_sparkline is ordered by sum of executed commands:
╭─#──┬──────user──────┬executions_total╮
│ 0  │ nu_scripts     │          61840 │
│ 1  │ maximuvarov    │          26526 │
│ 2  │ fdncred        │          17258 │
│ 3  │ kubouch        │           9159 │
│ 4  │ shinyzero0     │           8796 │
│ 5  │ dazfuller      │           7354 │
│ 6  │ cptpiepmatz    │           4199 │
│ 7  │ ErichDonGubler │           3382 │
│ 8  │ zjp            │           2643 │
│ 9  │ chtenb         │           2638 │
│ 10 │ sholderbach    │           2005 │
│ 11 │ horasal        │           1363 │
│ 12 │ nu_std         │           1139 │
│ 13 │ pingiun        │            884 │
│ 14 │ nicokosi       │            255 │
╰────┴────────────────┴────────────────╯

users_c_rank is the normalized geometric mean of users_count and users_freq_norm_avg.
╭────────name─────────┬────────category────────┬─users_count─┬─users_freq_norm_avg─┬─users_sparkline─┬─users_c_rank─┬─users_c_rank_bar─╮
│ ls                  │ filesystem             │          14 │                0.77 │ ▆▆███▄▄██▁▆█▁▆▇ │         1.00 │ ████████████████ │
│ cd                  │ filesystem             │          14 │                0.55 │ ▂▃▄▇▁██▃▇█▄▄▁█▁ │         0.85 │ █████████████▋   │
│ get                 │ filters                │          15 │                0.39 │ ██▅▆▄▃▁▁▂▁▃▂▃▂█ │         0.74 │ ███████████▉     │
│ open                │ filesystem             │          15 │                0.37 │ ▆█▄▄▄▃▆▂▂▁▃▃▁▂▇ │         0.72 │ ███████████▌     │
│ help                │ core                   │          13 │                0.39 │ ▂▃▅▃▂▂▂▁▃▁█▁▁▇█ │         0.69 │ ███████████      │
│ let                 │ core                   │          13 │                0.27 │ █▆▅▃▂▁▁▁▃▁▂▂▇▃▁ │         0.57 │ █████████▏       │
│ config              │ env                    │          14 │                0.21 │ ▁▃▃█▅▁▂▂▆▂▂▂▁▆▅ │         0.52 │ ████████▍        │
│ where               │ filters                │          12 │                0.20 │ ▆█▇▆▄▅▃▂▂▁▇▄▄▁▁ │         0.47 │ ███████▌         │
│ each                │ filters                │          13 │                0.18 │ ██▅▇▃▁▂▂▂▁▄▃▃▁▁ │         0.47 │ ███████▌         │
│ source              │ core                   │          10 │                0.23 │ ▅▆▆▄▁█▂▁▂▆▁▁▁▄▁ │         0.46 │ ███████▍         │
│ if                  │ core                   │           8 │                0.23 │ ▃▂▂▂▁▁▁▁▁▁▂▁█▁▁ │         0.41 │ ██████▋          │
│ echo                │ core                   │          12 │                0.14 │ ▂▃▃▂▂▁▁▂▃▁▅▁▁█▇ │         0.40 │ ██████▍          │
│ rm                  │ filesystem             │          14 │                0.12 │ ▂▂▂▃▅▃▃▃▅▁▂▂▁█▁ │         0.40 │ ██████▍          │
│ lines               │ filters                │          13 │                0.12 │ ▆▅▆▇█▂▆▃█▂▆▃▂▁▁ │         0.38 │ ██████▏          │
│ debug               │ debug                  │           9 │                0.16 │ ▁▁▃▂▁▁▃▁█▁▁▂▁▃▁ │         0.36 │ █████▊           │
│ path                │ path                   │          10 │                0.14 │ ▁▄▄▅▁▂▅▃█▁▁▄▁▇▁ │         0.36 │ █████▊           │
│ first               │ filters                │          11 │                0.11 │ ▆█▃▁▁▁▃▂▂▁▂▁▁▁▁ │         0.34 │ █████▌           │
│ ansi                │ platform               │           8 │                0.15 │ ▃▂▂▁▁▁▁▁▁▁▂▁█▁▁ │         0.34 │ █████▍           │
│ select              │ filters                │          10 │                0.11 │ ▆█▅▁▂▅▃▄▁▁▁▂▂▁▁ │         0.33 │ █████▎           │
│ profile             │ debug                  │           7 │                0.16 │ ▁▁▁█▂▁▁▁▁▁▁▁▁▆▁ │         0.32 │ █████▏           │
│ def                 │ core                   │           8 │                0.13 │ ▅▃▅▄▂▁▁▁▁▁▄▁█▄▁ │         0.32 │ █████            │
│ find                │ filters                │          11 │                0.09 │ ▂▂▃▄▃▁▁▁▂▂▂▁▂▃█ │         0.31 │ ████▉            │
│ print               │ strings                │          11 │                0.09 │ ▅▄▅▂▄▁▁▂█▁▃▂▂▆▁ │         0.31 │ ████▉            │
│ table               │ viewers                │          10 │                0.10 │ ▂▂▇▄▂▂▁▁▃▁▄▁▁▁█ │         0.31 │ ████▉            │
│ ps                  │ system                 │           7 │                0.14 │ ▁▁▂▁▂▁▁▁▁█▂▁▁▅▁ │         0.31 │ ████▉            │
│ sys                 │ system                 │           8 │                0.12 │ ▁▁▁▁▁▁▁▁▂▁▂▁▁▁█ │         0.30 │ ████▉            │
│ from json           │ formats                │           8 │                0.12 │ ▆▇▃▁▄▃▂▁▁▁█▁▁▁▁ │         0.30 │ ████▊            │
│ sort-by             │ filters                │          10 │                0.09 │ ▅▇▄▃▂▁▁▁▁▁▂▂▁▁█ │         0.30 │ ████▊            │
│ which               │ system                 │          12 │                0.08 │ ▂▂▂▂▃▁▂▁▄▁▁▂▁█▁ │         0.29 │ ████▋            │
│ all                 │ filters                │          10 │                0.09 │ ▁▂▂█▁▂▂▆▁▂▅▁▁▁▁ │         0.29 │ ████▋            │
│ update              │ filters                │          12 │                0.07 │ ▁▂▅▆▄█▅▃▂▄▃▁▃▁▁ │         0.29 │ ████▋            │
│ length              │ filters                │           8 │                0.11 │ ▇█▃▃▂▁▁▁▁▁▂▁▃▁▁ │         0.28 │ ████▌            │
│ do                  │ core                   │          10 │                0.08 │ ▃▃▃▂▂▁▂▁▄▁▄▁▂█▁ │         0.28 │ ████▌            │
│ flatten             │ filters                │           9 │                0.09 │ ██▅▅▃▃▁▂▁▁▆▁▅▁▁ │         0.28 │ ████▌            │
│ upsert              │ filters                │           4 │                0.20 │ ██▃▁▁▁▁▁▁▁▁▁▁▁▁ │         0.28 │ ████▍            │
│ let-env             │ removed                │           8 │                0.09 │ ▂▂▄▅▂▁▂▁█▁▁▁▁▆▁ │         0.26 │ ████▎            │
│ encode              │ strings                │           4 │                0.18 │ ▁▁▁▄▁▁▁▁▁▁▁█▁▁▁ │         0.26 │ ████▎            │
│ save                │ filesystem             │          12 │                0.06 │ ▇█▃▃▅▂▄▂▂▁▅▃▁▁▁ │         0.26 │ ████▏            │
│ transpose           │ filters                │           9 │                0.08 │ ▅▇█▃▂▂▁▁▁▁▇▁▂▇▁ │         0.25 │ ████             │
│ str join            │ strings                │           9 │                0.08 │ ▅▃▃▁▂▁▁▄▃▁▆▃█▁▁ │         0.25 │ ████             │
│ http get            │ network                │           7 │                0.10 │ ▂▁▃▁▃▂█▁▁▁▁▁▁▆▁ │         0.25 │ ████             │
│ from                │ formats                │          10 │                0.07 │ ▁█▂▂▁▂█▂▁▁▂▁▁▁▁ │         0.25 │ ████             │
│ describe            │ core                   │           9 │                0.07 │ ▄▄▅▃▇▁▁▂▂▁█▁▃▁▁ │         0.25 │ ████             │
│ dfr open            │ dataframe              │           4 │                0.16 │ ▁▂▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.24 │ ███▉             │
│ version             │ core                   │          10 │                0.06 │ ▁▁▂▂▂▂▁▁▃▁▃▂▁█▁ │         0.24 │ ███▉             │
│ last                │ filters                │           8 │                0.08 │ ▆▅▄█▄▁▃▁▁▁▁▁▁▁▁ │         0.24 │ ███▉             │
│ is-empty            │ filters                │           7 │                0.08 │ ▂▁▁▁▁▁▁▁▁▁▂▁█▁▁ │         0.23 │ ███▊             │
│ overlay             │ core                   │           2 │                0.28 │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.23 │ ███▋             │
│ str replace         │ strings                │           7 │                0.08 │ █▇▅▁▃▁▃▁▂▁▁▁▁▁▁ │         0.22 │ ███▋             │
│ skip                │ filters                │           8 │                0.06 │ ▅▇▄█▃▁▁▇▁▁▁▁▂▁▁ │         0.22 │ ███▌             │
│ parse               │ strings                │           8 │                0.06 │ ▅█▄▂▄▁▂▂▁▁▁▁▁▁▁ │         0.22 │ ███▌             │
│ to text             │ formats                │           9 │                0.06 │ ▁▂▃▁▄▁▄▁▄▁█▃▁▁▁ │         0.22 │ ███▌             │
│ exit                │ shells                 │           6 │                0.08 │ ▂▁▁▂▁▁▅█▁▁▁▅▁▁▁ │         0.22 │ ███▌             │
│ mv                  │ filesystem             │           9 │                0.05 │ ▃▂▂▅▇▅▂▄█▁▁▁▁▁▁ │         0.21 │ ███▍             │
│ use                 │ core                   │           8 │                0.06 │ ▃▂▂█▂▃▁▁▁▁▁▁▂▇▁ │         0.21 │ ███▍             │
│ history             │ misc                   │           7 │                0.07 │ ▆██▂▃▁▁▁▁▂▅▁▁▁▁ │         0.21 │ ███▍             │
│ merge               │ filters                │           8 │                0.06 │ ▄▄█▄▂▄▁▃▁▁▁▁▂▁▁ │         0.21 │ ███▍             │
│ clear               │ platform               │           5 │                0.09 │ ▁▁▁▁▁█▂▁▁▁▁▁▁▁▁ │         0.21 │ ███▎             │
│ append              │ filters                │           7 │                0.07 │ ▇█▃▄▃▁▁▄▁▁▁▁▆▁▁ │         0.21 │ ███▎             │
│ mkdir               │ filesystem             │           9 │                0.05 │ ▂▃▂▄▄▄▃▁▄▁█▁▁▁▁ │         0.20 │ ███▎             │
│ try                 │ core                   │           8 │                0.05 │ ▂▂▂▁▁▁▁▆▁▁▅▁▄█▁ │         0.20 │ ███▏             │
│ extern              │ core                   │           2 │                0.21 │ ▁▁▁▇▁▁▁▁▁▁▁▁▁█▁ │         0.20 │ ███▏             │
│ split row           │ strings                │           6 │                0.07 │ ▆▆▄▂▃▁▁▁▁▁▁▁▁█▁ │         0.20 │ ███▏             │
│ any                 │ filters                │           7 │                0.06 │ ▁▁▂▁▃▁▁▂▃▁█▁▂▁▁ │         0.19 │ ███▏             │
│ for                 │ core                   │          10 │                0.04 │ ▂▂▄▂▃▁▁▄▁▄█▁▂▁▁ │         0.19 │ ███              │
│ complete            │ system                 │           8 │                0.05 │ ▂▃▂▁▂▁▂▁▁▁▁▁▁█▁ │         0.19 │ ███              │
│ char                │ strings                │           6 │                0.06 │ ▄▂▅▃▁▁▁▁▁▁▁▁▄█▁ │         0.19 │ ███              │
│ overlay use         │ core                   │           3 │                0.12 │ ▅█▁▃▁▁▁▁▁▁▁▁▁▁▁ │         0.19 │ ███              │
│ to                  │ formats                │           9 │                0.04 │ ▁█▂▄▃▂▄▄▁▄▁▁▁▁▁ │         0.18 │ ███              │
│ register            │ core                   │           6 │                0.06 │ ▁▁▆▂▁▁█▁▁▁▁▆▁▁▁ │         0.18 │ ██▉              │
│ export def          │ core                   │           4 │                0.09 │ ▃▂▁▂▁▁▁▁▁▁▁▁█▁▁ │         0.18 │ ██▉              │
│ decode              │ strings                │           3 │                0.11 │ ▁▁▂▁▁▁▁▁▁▁▁█▁▁▁ │         0.18 │ ██▉              │
│ metadata            │ debug                  │           5 │                0.07 │ ▁▁▁▁▁▃▁▁▁▁▃▁█▁▁ │         0.18 │ ██▉              │
│ dfr into-df         │ dataframe              │           3 │                0.11 │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.17 │ ██▊              │
│ explore             │ viewers                │           6 │                0.05 │ ▂▃▆▁▂▁█▁▁▁▇▁▁▁▁ │         0.17 │ ██▊              │
│ into int            │ conversions            │           7 │                0.05 │ ▆█▇▃▁▂▃▁▁▁▁▁▃▁▁ │         0.17 │ ██▊              │
│ timeit              │ debug                  │           7 │                0.04 │ ▅▃▂▁▃▂▁▁█▁▁▁▁▁▁ │         0.17 │ ██▊              │
│ filter              │ filters                │           8 │                0.04 │ ▂▁▂▂▂▂▅▁█▁▁▁▄▁▁ │         0.17 │ ██▊              │
│ cp                  │ filesystem             │           7 │                0.04 │ ▂▃▂▅▅▁▁▃█▁▁▁▁▁▁ │         0.17 │ ██▋              │
│ reject              │ filters                │           8 │                0.04 │ █▆▄▄▃▁▂▃▁▁▁▁▃▁▁ │         0.17 │ ██▋              │
│ default             │ filters                │           7 │                0.04 │ ▄▄▅█▃▁▁▄▁▁▁▁▄▁▁ │         0.17 │ ██▋              │
│ into                │ conversions            │           4 │                0.07 │ ▁▁▃▂▁▁▁▁▁▁█▁▁▁▁ │         0.16 │ ██▋              │
│ uniq                │ filters                │           5 │                0.06 │ ▆█▃▁▃▁▁▁▁▁█▁▁▁▁ │         0.16 │ ██▋              │
│ group-by            │ filters                │           6 │                0.05 │ ▅▄▅█▁▂▁▁▁▁▁▁▁▁▁ │         0.16 │ ██▋              │
│ reverse             │ filters                │           4 │                0.07 │ ▂▅▂▁▁▁▁▁▁▁█▁▁▁▁ │         0.16 │ ██▋              │
│ size                │ strings                │           7 │                0.04 │ ▁█▆▆▂▂▁▁▁▁▁▄▁▁▁ │         0.16 │ ██▋              │
│ columns             │ filters                │           8 │                0.03 │ ▅█▄▃▂▂▂▁▁▁▁▁▂▁▁ │         0.16 │ ██▌              │
│ help commands       │ core                   │           7 │                0.04 │ ▃▂█▃▁▂▄▁▁▁▁▇▁▁▁ │         0.16 │ ██▌              │
│ url                 │ network                │           3 │                0.09 │ ▁▁▂▁▁▁▁▁▁▁█▁▁▁▁ │         0.16 │ ██▌              │
│ config nu           │ env                    │           4 │                0.06 │ ▅█▁▃▁▁▁▁▁▁▇▁▁▁▁ │         0.15 │ ██▌              │
│ start               │ filesystem             │           6 │                0.04 │ ▂▃▂▁▃▁█▃▁▁▁▁▁▁▁ │         0.15 │ ██▍              │
│ fill                │ conversions            │           5 │                0.05 │ ▂▂▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.15 │ ██▍              │
│ dfr col             │ expression             │           3 │                0.08 │ █▄▁▁▁▁▁▁▁▁▁▄▁▁▁ │         0.15 │ ██▍              │
│ run-external        │ system                 │           2 │                0.12 │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁ │         0.15 │ ██▍              │
│ par-each            │ filters                │           3 │                0.08 │ ▅█▁▁▁▁▁▁▁▁▁▁▂▁▁ │         0.15 │ ██▍              │
│ input               │ platform               │           6 │                0.04 │ ▁▁▂▁▂█▁▁▁▂▁▁▁▁▁ │         0.15 │ ██▍              │
│ from tsv            │ formats                │           4 │                0.06 │ ▁▂▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.15 │ ██▍              │
│ commandline         │ core                   │           3 │                0.08 │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.15 │ ██▍              │
│ mut                 │ core                   │           6 │                0.04 │ ▃▃▃▅▂▁▁▁▁▁▁▁█▁▁ │         0.15 │ ██▍              │
│ rename              │ filters                │           7 │                0.03 │ ▇█▆▁▃▂▁▄▁▁▁▁▄▁▁ │         0.14 │ ██▎              │
│ date now            │ date                   │           6 │                0.04 │ █▇▆▁▂▁▁▁▁▁▆▁▂▁▁ │         0.14 │ ██▎              │
│ path expand         │ path                   │           7 │                0.03 │ ▂▂▃▂▆▁▁█▁▁▁▁▂▁▁ │         0.14 │ ██▎              │
│ error make          │ core                   │           5 │                0.04 │ ▁▁▂▂▁▁▁▁▁▁▅▁█▁▁ │         0.14 │ ██▎              │
│ glob                │ filesystem             │           5 │                0.04 │ █▅▄▁▃▂▁▁▁▁▁▁▁▁▁ │         0.14 │ ██▏              │
│ path join           │ path                   │           7 │                0.03 │ ▂▁▃▅▇▁▁▃▁▁█▁▄▁▁ │         0.14 │ ██▏              │
│ into datetime       │ conversions            │           4 │                0.05 │ ▄▄█▁▁▁▂▁▁▁▁▁▁▁▁ │         0.14 │ ██▏              │
│ ignore              │ core                   │           5 │                0.04 │ ▁▂▁▁▂▁▁▁▁▁▁▁▁█▁ │         0.13 │ ██▏              │
│ str substring       │ strings                │           5 │                0.04 │ ▅▆▂▁▁▁▁▁▁▁█▁▂▁▁ │         0.13 │ ██▏              │
│ prepend             │ filters                │           5 │                0.04 │ ▂▁▂▁▂▁▁▁▁▁▁▁▁█▁ │         0.13 │ ██▏              │
│ reduce              │ filters                │           5 │                0.04 │ ██▆▁▃▁▁▁▁▁▁▁▄▁▁ │         0.13 │ ██▏              │
│ http                │ network                │           4 │                0.04 │ ▁▁▂▁▄▁█▁▁▁▁▁▁▁▁ │         0.13 │ ██               │
│ str trim            │ strings                │           6 │                0.03 │ ▃▃█▃▄▁▁▁▁▁▁▁▂▁▁ │         0.13 │ ██               │
│ drop                │ filters                │           5 │                0.03 │ ▂▂▁█▁▁▁▂▁▁▁▁▁▁▁ │         0.13 │ ██               │
│ insert              │ filters                │           6 │                0.03 │ ▆▇▁▇▁▅▁▁▁▃▁▁█▁▁ │         0.12 │ ██               │
│ path parse          │ path                   │           7 │                0.02 │ ▂▃▃▃▃▁▁▁▁▁█▁▂▁▁ │         0.12 │ ██               │
│ from csv            │ formats                │           5 │                0.03 │ ▂▂▂▁▁▂█▁▁▁▁▁▁▁▁ │         0.12 │ ██               │
│ to json             │ formats                │           5 │                0.03 │ ▄▂▆▁▂▁█▁▁▁▁▁▁▁▁ │         0.12 │ █▉               │
│ dfr filter-with     │ dataframe or lazyframe │           3 │                0.05 │ ▇█▁▁▁▁▁▁▁▁▁▆▁▁▁ │         0.12 │ █▉               │
│ into binary         │ conversions            │           4 │                0.04 │ ▂▂█▁▁▁▁▁▁▁▁▅▁▁▁ │         0.12 │ █▉               │
│ into record         │ conversions            │           6 │                0.03 │ ▄▅▇▁▄▁▁▁█▁▁▁▃▁▁ │         0.12 │ █▉               │
│ to nuon             │ formats                │           6 │                0.02 │ ▂▂▂▁▂▁▁▁▁▁█▁▁▁▁ │         0.12 │ █▉               │
│ module              │ core                   │           3 │                0.05 │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.11 │ █▊               │
│ dfr filter          │ lazyframe              │           3 │                0.04 │ ▄▂▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.11 │ █▊               │
│ exec                │ system                 │           4 │                0.03 │ ▁▂▁▁▂▁▁▁▁▁▁▁▁█▁ │         0.11 │ █▊               │
│ wrap                │ filters                │           4 │                0.03 │ ▆█▆▁▃▁▁▁▁▁▁▁▁▁▁ │         0.11 │ █▊               │
│ du                  │ core                   │           5 │                0.03 │ ▁▁▂▃▁▂▁▁▁▁█▁▁▁▁ │         0.11 │ █▊               │
│ from xml            │ formats                │           3 │                0.04 │ ▁▁▁█▂▁▁▁▁▁▁▁▁▁▁ │         0.11 │ █▊               │
│ dfr sort-by         │ lazyframe              │           3 │                0.04 │ ▇█▁▃▁▁▁▁▁▁▁▁▁▁▁ │         0.11 │ █▊               │
│ split chars         │ strings                │           4 │                0.03 │ ▂▂▄▁▁▁▁▁▁▁▁█▁▁▁ │         0.11 │ █▊               │
│ split column        │ strings                │           4 │                0.03 │ ▂▂█▁▁▂▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │
│ str starts-with     │ strings                │           5 │                0.02 │ ▄▃▁▁▄▁▁▁▁▁█▁▃▁▁ │         0.10 │ █▋               │
│ to yaml             │ formats                │           2 │                0.06 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │
│ from nuon           │ formats                │           2 │                0.06 │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.10 │ █▋               │
│ continue            │ core                   │           2 │                0.06 │ ▁▁▁▁▁▁▁█▁▂▁▁▁▁▁ │         0.10 │ █▋               │
│ str contains        │ strings                │           4 │                0.03 │ ▂▃▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │
│ alias               │ core                   │           5 │                0.02 │ ▃▂▆█▁▁▁▁▁▁▁▁▃▁▁ │         0.10 │ █▋               │
│ zip                 │ filters                │           7 │                0.02 │ ▂█▇▆▅▁▇▁▁▁▁▁▄▁▁ │         0.10 │ █▋               │
│ dfr with-column     │ dataframe or lazyframe │           2 │                0.05 │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │
│ enumerate           │ filters                │           5 │                0.02 │ █▅▄▁▃▁▁▁▁▁▁▁█▁▁ │         0.10 │ █▋               │
│ return              │ core                   │           4 │                0.03 │ ▂▂▂▁▁▁▁▁▁▁▁▁█▁▁ │         0.10 │ █▋               │
│ collect             │ filters                │           4 │                0.03 │ ▁▁▂█▂▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │
│ export              │ core                   │           3 │                0.03 │ ▁▁▁█▁▄▁▁▁▁▁▁▁▁▁ │         0.10 │ █▌               │
│ dfr select          │ lazyframe              │           2 │                0.05 │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▌               │
│ dfr get             │ dataframe              │           3 │                0.03 │ ▅█▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.10 │ █▌               │
│ with-env            │ env                    │           3 │                0.03 │ ▁▁▁▁▂▁▁█▁▁▁▁▁▁▁ │         0.10 │ █▌               │
│ items               │ filters                │           4 │                0.02 │ ▆▁▂▁▃▁█▁▁▁▁▁▁▁▁ │         0.10 │ █▌               │
│ dfr as              │ expression             │           3 │                0.03 │ █▄▁▄▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▌               │
│ values              │ filters                │           5 │                0.02 │ █▇▃▁▁▂▁▁▁▁▁▁▂▁▁ │         0.10 │ █▌               │
│ into string         │ conversions            │           4 │                0.02 │ ▇█▅▁▁▁▁▁▁▁▁▁▂▁▁ │         0.10 │ █▌               │
│ str length          │ strings                │           3 │                0.03 │ ▅▅█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.09 │ █▌               │
│ math sum            │ math                   │           5 │                0.02 │ ▅▅▃█▁▁▁▁▁▃▁▁▁▁▁ │         0.09 │ █▌               │
│ dfr into-nu         │ dataframe              │           1 │                0.09 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.09 │ █▌               │
│ dfr into-lazy       │ lazyframe              │           2 │                0.04 │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.09 │ █▌               │
│ date format         │ removed                │           3 │                0.03 │ ▃▄█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.09 │ █▍               │
│ inspect             │ debug                  │           4 │                0.02 │ ▅▆▆▁▁▁▁▁█▁▁▁▁▁▁ │         0.09 │ █▍               │
│ view                │ debug                  │           5 │                0.02 │ ▁▃▃█▁▅▁▁▁▁▁▁▁▁▁ │         0.09 │ █▍               │
│ math avg            │ math                   │           3 │                0.03 │ ▁▁▁█▁▁▁▁▁▁▁▁▂▁▁ │         0.09 │ █▍               │
│ dfr rename          │ dataframe or lazyframe │           2 │                0.04 │ ██▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▍               │
│ window              │ filters                │           4 │                0.02 │ ▃█▆▁▆▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▍               │
│ const               │ core                   │           3 │                0.02 │ ▁▁▁█▁▁▁▁▁▁▁▁▅▁▁ │         0.08 │ █▍               │
│ dfr join            │ lazyframe              │           2 │                0.04 │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │
│ path split          │ path                   │           3 │                0.02 │ ▁▁▁▁▇▁▁▁█▁▁▁▁▁▁ │         0.08 │ █▎               │
│ into decimal        │ conversions            │           4 │                0.02 │ ▂▁▂█▁▁▁▁▁▁▁▁▂▁▁ │         0.08 │ █▎               │
│ overlay list        │ core                   │           3 │                0.02 │ ▂▃▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │
│ export alias        │ core                   │           2 │                0.03 │ █▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.08 │ █▎               │
│ term size           │ platform               │           4 │                0.02 │ ▃▃█▁▁▅▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │
│ keybindings         │ platform               │           4 │                0.02 │ ▁▅█▁▃▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │
│ nu-highlight        │ strings                │           4 │                0.02 │ ▂▁▂█▁▁▁▁▁▁▁▁▆▁▁ │         0.08 │ █▎               │
│ match               │ core                   │           2 │                0.03 │ ▂▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.08 │ █▎               │
│ to md               │ formats                │           5 │                0.01 │ ▃▄▄█▁▁▆▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │
│ dfr contains        │ dataframe              │           2 │                0.03 │ ▂▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.07 │ █▎               │
│ sleep               │ platform               │           3 │                0.02 │ ▁▁▆▁█▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ histogram           │ chart                  │           3 │                0.02 │ ▁▁▂█▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ dfr group-by        │ lazyframe              │           3 │                0.02 │ ▅▅▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ move                │ filters                │           4 │                0.01 │ █▆▁▁▆▁▁█▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ seq                 │ generators             │           4 │                0.01 │ ▅▃█▁▁▁▁▁▁▁▁▁▄▁▁ │         0.07 │ █▏               │
│ path basename       │ path                   │           3 │                0.02 │ ▇█▁▁▆▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ tutor               │ misc                   │           2 │                0.03 │ ▁▂▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.07 │ █▏               │
│ from yaml           │ formats                │           2 │                0.03 │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ path dirname        │ path                   │           4 │                0.01 │ ▂▁▃▁▁▁▁▁█▁▁▁▂▁▁ │         0.07 │ █▏               │
│ sort                │ filters                │           3 │                0.02 │ ▄▁▁▁▁▇▁█▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ dfr unique          │ dataframe or lazyframe │           2 │                0.03 │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ ansi strip          │ platform               │           3 │                0.02 │ ▃▁█▁▁▁▁▁▁▁▁▁▂▁▁ │         0.07 │ █▏               │
│ dfr drop            │ dataframe              │           2 │                0.03 │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ overlay hide        │ core                   │           3 │                0.02 │ ▄▇▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ dfr agg             │ lazyframe              │           3 │                0.02 │ ▅▅▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ dfr collect         │ lazyframe              │           2 │                0.02 │ ▆█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │
│ take                │ filters                │           3 │                0.02 │ ▁▁█▁▁▁▁▁▁▁▁▁▂▁▁ │         0.07 │ █▏               │
│ bytes at            │ bytes                  │           1 │                0.04 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ into duration       │ conversions            │           3 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▂▁▁ │         0.06 │ █                │
│ dfr append          │ dataframe              │           2 │                0.02 │ █▆▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ export def-env      │ core                   │           2 │                0.02 │ ▂▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.06 │ █                │
│ group               │ filters                │           3 │                0.01 │ ▁▁▆▁▁█▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ while               │ core                   │           3 │                0.01 │ ▁▁█▁▆▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ to csv              │ formats                │           3 │                0.01 │ █▅▇▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ path exists         │ path                   │           5 │                0.01 │ █▄█▁▆▁▁▁▁▁▁▁▄▁▁ │         0.06 │ █                │
│ seq date            │ generators             │           3 │                0.01 │ ▅██▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ view source         │ debug                  │           3 │                0.01 │ ██▁▁▁▁▁▁▁▁▁▁▆▁▁ │         0.06 │ █                │
│ schema              │ database               │           3 │                0.01 │ ▁▁█▁▁▇▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │
│ from ssv            │ formats                │           2 │                0.02 │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ ▉                │
│ random integer      │ random                 │           2 │                0.02 │ ▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.06 │ ▉                │
│ skip until          │ filters                │           2 │                0.02 │ █▁▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.06 │ ▉                │
│ config env          │ env                    │           3 │                0.01 │ ▆▇▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ ▉                │
│ math abs            │ math                   │           2 │                0.02 │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ ▉                │
│ headers             │ filters                │           4 │                0.01 │ ▇█▇▁▁▁▁▁▁▁▁▁▅▁▁ │         0.06 │ ▉                │
│ path relative-to    │ path                   │           3 │                0.01 │ ▁▁▁▇█▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │
│ detect columns      │ strings                │           2 │                0.02 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │
│ dfr value-counts    │ dataframe              │           2 │                0.02 │ ▅█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │
│ str                 │ strings                │           3 │                0.01 │ ▆▁▁▁▁▇▁▁▁█▁▁▁▁▁ │         0.05 │ ▉                │
│ path type           │ path                   │           3 │                0.01 │ ▁▁▁▁█▁▁▁▁▁▁▁▃▁▁ │         0.05 │ ▉                │
│ hide                │ core                   │           3 │                0.01 │ ▁▁▅█▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │
│ scope commands      │ filters                │           2 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.05 │ ▉                │
│ hash                │ hash                   │           1 │                0.03 │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▊                │
│ date                │ date                   │           1 │                0.03 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▊                │
│ cal                 │ generators             │           1 │                0.03 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▊                │
│ range               │ filters                │           3 │                0.01 │ ▃██▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▊                │
│ touch               │ filesystem             │           3 │                0.01 │ ▂▄▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▊                │
│ http post           │ network                │           2 │                0.01 │ ▃▁▁▁▁▁█▁▁▁▁▁▁▁▁ │         0.05 │ ▊                │
│ keybindings listen  │ platform               │           3 │                0.01 │ ▂▁█▁▆▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │
│ dfr concat-str      │ expression             │           2 │                0.01 │ █▃▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │
│ export-env          │ env                    │           2 │                0.01 │ ▃▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.04 │ ▊                │
│ dfr count           │ expression             │           2 │                0.01 │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │
│ explain             │ debug                  │           2 │                0.01 │ ▄█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │
│ scope               │ core                   │           2 │                0.01 │ ▁▁▁▁▁█▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ overlay new         │ core                   │           2 │                0.01 │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ decode base64       │ hash                   │           2 │                0.01 │ ▂▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ break               │ core                   │           3 │                0.01 │ ▂▁█▁▆▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ grid                │ viewers                │           2 │                0.01 │ ▂▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ kill                │ platform               │           2 │                0.01 │ ▁▁▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ join                │ filters                │           3 │                0.01 │ ▂▆█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ math floor          │ math                   │           2 │                0.01 │ ▅█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ dfr shape           │ dataframe              │           2 │                0.01 │ ██▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ random              │ random                 │           2 │                0.01 │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ def-env             │ core                   │           3 │                0.01 │ ▄▁█▁▁▁▁▁▁▁▁▁▅▁▁ │         0.04 │ ▋                │
│ dfr set             │ dataframe              │           2 │                0.01 │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ to tsv              │ formats                │           2 │                0.01 │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ dfr first           │ dataframe              │           1 │                0.02 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ take while          │ filters                │           2 │                0.01 │ ▁▁▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ random chars        │ random                 │           2 │                0.01 │ ▄▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.04 │ ▋                │
│ compact             │ filters                │           2 │                0.01 │ ▂▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ dfr not             │ dataframe              │           2 │                0.01 │ █▅▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ math round          │ math                   │           2 │                0.01 │ █▅▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │
│ format date         │ date                   │           2 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▆▁▁ │         0.04 │ ▋                │
│ math ceil           │ math                   │           2 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ help operators      │ core                   │           2 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ ast                 │ debug                  │           2 │                0.01 │ ▄█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ loop                │ core                   │           3 │                0.00 │ ▁▁█▁▁▁▁▁▁▁▁▁▇▁▁ │         0.03 │ ▌                │
│ dfr fill-null       │ lazyframe              │           2 │                0.01 │ █▆▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ bytes length        │ bytes                  │           2 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ dfr lit             │ expression             │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ bytes               │ bytes                  │           1 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ date to-record      │ date                   │           2 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▌                │
│ scope modules       │ filters                │           1 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▌                │
│ scope aliases       │ filters                │           1 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▌                │
│ input listen        │ platform               │           1 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▌                │
│ date to-timezone    │ date                   │           1 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▌                │
│ dfr fetch           │ lazyframe              │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ dfr columns         │ dataframe              │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ history session     │ misc                   │           2 │                0.00 │ ▇█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ keybindings list    │ platform               │           2 │                0.00 │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ view files          │ debug                  │           1 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ split words         │ strings                │           1 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ bytes index-of      │ bytes                  │           1 │                0.01 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ dfr arg-where       │ expression             │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ keybindings default │ platform               │           2 │                0.00 │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ math max            │ math                   │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ dfr is-in           │ expression             │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ dfr reverse         │ lazyframe              │           2 │                0.00 │ ▆█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │
│ into filesize       │ conversions            │           2 │                0.00 │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │
│ dfr dtypes          │ dataframe              │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │
│ dfr str-slice       │ dataframe              │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │
│ load-env            │ filesystem             │           2 │                0.00 │ ▄▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▍                │
│ take until          │ filters                │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │
│ str upcase          │ strings                │           2 │                0.00 │ ▄▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.03 │ ▍                │
│ help aliases        │ core                   │           2 │                0.00 │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │
│ dfr max             │ expression             │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ to toml             │ formats                │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ dfr when            │ expression             │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ hash sha256         │ hash                   │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ math stddev         │ math                   │           1 │                0.01 │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.02 │ ▍                │
│ input list          │ platform               │           1 │                0.01 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ math min            │ math                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ dfr min             │ expression             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ dfr drop-duplicates │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ scope variables     │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │
│ dfr str-lengths     │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ dfr is-null         │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ dfr sum             │ expression             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ hide-env            │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ dfr concatenate     │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ str downcase        │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ date humanize       │ date                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ dfr otherwise       │ expression             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │
│ dfr drop-nulls      │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr replace         │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr last            │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ uniq-by             │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ math log            │ math                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr to-csv          │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr take            │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr get-nanosecond  │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr expr-not        │ expression             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ nu-check            │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr melt            │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ dfr explode         │ lazyframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │
│ str capitalize      │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ random dice         │ random                 │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ hash md5            │ hash                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr summary         │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr fill-nan        │ lazyframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr as-date         │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ str ends-with       │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr var             │ expression             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr to-parquet      │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ math median         │ math                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ is-admin            │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ encode base64       │ hash                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ drop nth            │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ str index-of        │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ split list          │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ split               │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ seq char            │ generators             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ math sqrt           │ math                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr replace-all     │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr is-unique       │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ str distance        │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ skip while          │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ help modules        │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr n-unique        │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr ls              │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr arg-unique      │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ url build-query     │ network                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ str expand          │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ shuffle             │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ random decimal      │ random                 │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ from toml           │ formats                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ export use          │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ drop column         │ filters                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr to-arrow        │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr is-not-null     │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr flatten         │ lazyframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr dummies         │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ dfr count-null      │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ date to-table       │ date                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │
│ watch               │ filesystem             │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ view span           │ debug                  │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ url join            │ network                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ random uuid         │ random                 │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ random bool         │ random                 │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ math product        │ math                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ lazy make           │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ help externs        │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ format duration     │ strings                │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ export extern       │ core                   │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ dfr is-duplicated   │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
│ dfr as-datetime     │ dataframe              │           1 │                0.00 │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │
╰────────name─────────┴────────category────────┴─users_count─┴─users_freq_norm_avg─┴─users_sparkline─┴─users_c_rank─┴─users_c_rank_bar─╯
```

```
> use v2-nu-commands-freq.nu nu-hist-stats;
> let $t1 = (nu_hist_stats); $t1
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
│ 3  │ kubouch        │           9159 │
│ 4  │ shinyzero0     │           8796 │
│ 5  │ dazfuller      │           7354 │
│ 6  │ cptpiepmatz    │           4199 │
│ 7  │ ErichDonGubler │           3382 │
│ 8  │ zjp            │           2643 │
│ 9  │ chtenb         │           2638 │
│ 10 │ sholderbach    │           2005 │
│ 11 │ horasal        │           1363 │
│ 12 │ nu_std         │           1139 │
│ 13 │ pingiun        │            884 │
│ 14 │ nicokosi       │            255 │
╰────┴────────────────┴────────────────╯

users_c_rank is the normalized geometric mean of users_count and users_freq_norm_avg.
╭────────name─────────┬────────category────────┬─freq─┬─freq_norm─┬─freq_norm_bar─┬─────────timeline─────────┬─users_c_rank─┬─users_c_rank_bar─┬─users_sparkline─╮
│ alias               │ core                   │   27 │      0.01 │               │ ▆▃▁▂▁▁▁▁▁▁▂▁▁▂▁█▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │ ▃▂▆█▁▁▁▁▁▁▁▁▃▁▁ │
│ all                 │ filters                │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁█▁ │         0.29 │ ████▋            │ ▁▂▂█▁▂▂▆▁▂▅▁▁▁▁ │
│ ansi                │ platform               │  457 │      0.10 │ █             │ ▁▁▅█▁▁▁▁▁▁▁▂▃▁▁▃▂▁▃▁▁▁▂▂ │         0.34 │ █████▍           │ ▃▂▂▁▁▁▁▁▁▁▂▁█▁▁ │
│ ansi strip          │ platform               │   53 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂█▁▂▁▅▃ │         0.07 │ █▏               │ ▃▁█▁▁▁▁▁▁▁▁▁▂▁▁ │
│ append              │ filters                │  396 │      0.08 │ ▉             │ ▃▂▃▃█▆▇▅▃▃▃▂▁▁▇▁▄▂▆▁▁▁▁▁ │         0.21 │ ███▎             │ ▇█▃▄▃▁▁▄▁▁▁▁▆▁▁ │
│ ast                 │ debug                  │   20 │      0.00 │               │ ▁▁▂▂▁▁▁▁▁▁▁▁█▅▁▂▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │ ▄█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ break               │ core                   │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁ │         0.04 │ ▋                │ ▂▁█▁▆▁▁▁▁▁▁▁▁▁▁ │
│ cd                  │ filesystem             │  813 │      0.17 │ █▊            │ ▃▆▅▅▄▂▇█▃▆▄▂▃▅▃▃▁▂▁▃▂▁▂▁ │         0.85 │ █████████████▋   │ ▂▃▄▇▁██▃▇█▄▄▁█▁ │
│ char                │ strings                │  128 │      0.03 │ ▎             │ ▁▁▁▂▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂█▃█ │         0.19 │ ███              │ ▄▂▅▃▁▁▁▁▁▁▁▁▄█▁ │
│ clear               │ platform               │  106 │      0.02 │ ▎             │ ▄▃▄▂▂▂▁▂▂▁▃▁▁▁▂▂▁▂▅▂▁█▁▂ │         0.21 │ ███▎             │ ▁▁▁▁▁█▂▁▁▁▁▁▁▁▁ │
│ collect             │ filters                │   24 │      0.01 │               │ ▁▇▁▁▁▁▂▂▃▃▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.10 │ █▋               │ ▁▁▂█▂▁▁▁▁▁▁▁▁▁▁ │
│ columns             │ filters                │  275 │      0.06 │ ▋             │ ▁▁▃▁▂▄▄██▄▆▂▁▃▁▂▂▁▄▄▂▁▁▁ │         0.16 │ ██▌              │ ▅█▄▃▂▂▂▁▁▁▁▁▂▁▁ │
│ commandline         │ core                   │   46 │      0.01 │ ▏             │ ▁▂▃▃▁▁▁▁▁▁▁▁▁▄▁█▁▁▁▁▁▁▁▁ │         0.15 │ ██▍              │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │
│ compact             │ filters                │    7 │      0.00 │               │ ▁▁▁█▁▁▁▃▁▃▁▁▁▁▁▁▁▆▁▁▁▁▁▁ │         0.04 │ ▋                │ ▂▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ complete            │ system                 │  132 │      0.03 │ ▎             │ ▆▄█▃▆▃█▃▁▃▂▂▁▁▅▂▂▁▁▁▂▁▁▁ │         0.19 │ ███              │ ▂▃▂▁▂▁▂▁▁▁▁▁▁█▁ │
│ config              │ env                    │    8 │      0.00 │               │ ▁▁▁█▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁ │         0.52 │ ████████▍        │ ▁▃▃█▅▁▂▂▆▂▂▂▁▆▅ │
│ config env          │ env                    │   45 │      0.01 │ ▏             │ ▁▃▂▁▂▂▃█▂▃▄▃▂▅▁▁▃▃▂▄▁▁▃▂ │         0.06 │ ▉                │ ▆▇▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ config nu           │ env                    │  279 │      0.06 │ ▋             │ ▄▆█▂▆▃▂▅▂▆▆█▂█▄▃▃▁▂▄▂▁▁▂ │         0.15 │ ██▌              │ ▅█▁▃▁▁▁▁▁▁▇▁▁▁▁ │
│ const               │ core                   │    1 │      0.00 │               │ ▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▍               │ ▁▁▁█▁▁▁▁▁▁▁▁▅▁▁ │
│ cp                  │ filesystem             │  100 │      0.02 │ ▎             │ ▁▄▁▁▁▁▃█▃▄▄▂▁▃▃▂▃▂▁▆▆▂▁▁ │         0.17 │ ██▋              │ ▂▃▂▅▅▁▁▃█▁▁▁▁▁▁ │
│ date format         │ removed                │   64 │      0.01 │ ▏             │ ▆▂▁▁▄▂▇▂▁▁▂▁▁▄█▁▁▁▁▁▂▁▁▁ │         0.09 │ █▍               │ ▃▄█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ date humanize       │ date                   │   13 │      0.00 │               │ ▄▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▄▁▁▁ │         0.02 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ date now            │ date                   │  264 │      0.06 │ ▌             │ ▃▃▁▁▇▄▆▆▂▂▅▃▇▃▇▁▃▂▆█▃▂▂▇ │         0.14 │ ██▎              │ █▇▆▁▂▁▁▁▁▁▆▁▂▁▁ │
│ date to-record      │ date                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ date to-table       │ date                   │    2 │      0.00 │               │ █▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ date to-timezone    │ date                   │    5 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.03 │ ▌                │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ debug               │ debug                  │   23 │      0.00 │               │ ▁▃▅█▃▁▁▂▁▁▁▄▁▁▁▂▁▁▁▁▂▁▂▂ │         0.36 │ █████▊           │ ▁▁▃▂▁▁▃▁█▁▁▂▁▃▁ │
│ decode              │ strings                │   12 │      0.00 │               │ ▁▁▁▁▃▁▁▁▁▁▁▁█▂▁▁▁▅▁▁▁▁▁▁ │         0.18 │ ██▉              │ ▁▁▂▁▁▁▁▁▁▁▁█▁▁▁ │
│ decode base64       │ hash                   │   13 │      0.00 │               │ ▁▁▁▁▁▁▁▁█▁▁▁▁▃▁▁▁▃▁▁▁▁▁▁ │         0.04 │ ▋                │ ▂▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ def                 │ core                   │  327 │      0.07 │ ▊             │ ▄█▄▃▂▃▁▁▂▂▃▁▂▁▁▄▂▂▃▂▁▃▂▃ │         0.32 │ █████            │ ▅▃▅▄▂▁▁▁▁▁▄▁█▄▁ │
│ def-env             │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.04 │ ▋                │ ▄▁█▁▁▁▁▁▁▁▁▁▅▁▁ │
│ default             │ filters                │  177 │      0.04 │ ▍             │ ▁▁▁▃▁▆▁▃▂▃▁▁▁▁▃▃▂▁▁█▂▁▇█ │         0.17 │ ██▋              │ ▄▄▅█▃▁▁▄▁▁▁▁▄▁▁ │
│ describe            │ core                   │  343 │      0.07 │ ▊             │ ▃▁▁▁▁▂▁▂▅▆▂▂▁▁▂▁▂▂█▂▁▂▃▃ │         0.25 │ ████             │ ▄▄▅▃▇▁▁▂▂▁█▁▃▁▁ │
│ detect columns      │ strings                │    3 │      0.00 │               │ ▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr agg             │ lazyframe              │   64 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▃▁█▁▁▁▁▇▁▁▁▂▂▁▁▁▁ │         0.07 │ █▏               │ ▅▅▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr append          │ dataframe              │  129 │      0.03 │ ▎             │ ▁▁▁▁▁▁▁▁▁▃▁▄▁▁█▂▁▁▁▁▂▁▁▁ │         0.06 │ █                │ █▆▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr arg-unique      │ dataframe              │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▅▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr arg-where       │ expression             │   44 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▄▁▁▁▃▁▁█▄▁▁▂▁▄▁▅▁ │         0.03 │ ▌                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr as              │ expression             │  254 │      0.05 │ ▌             │ ▁▁▁▁▁▁▁▃▁▂▂▃▁▁█▁▁▁▂▁▂▁▃▁ │         0.10 │ █▌               │ █▄▁▄▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr as-date         │ dataframe              │   27 │      0.01 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁█ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr as-datetime     │ dataframe              │   16 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr col             │ expression             │  643 │      0.14 │ █▍            │ ▁▁▁▁▁▁▁▃▁▄▃▃▁▁█▂▁▁▂▂▂▁▃▁ │         0.15 │ ██▍              │ █▄▁▁▁▁▁▁▁▁▁▄▁▁▁ │
│ dfr collect         │ lazyframe              │  106 │      0.02 │ ▎             │ ▁▁▁▁▁▁▁▂▁▅▄█▁▁▁▂▁▁▂▃▁▁▁▁ │         0.07 │ █▏               │ ▆█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr columns         │ dataframe              │   49 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▂▃▁▃▁▁▁▁█▂▁▃▁▄▃▁▁ │         0.03 │ ▌                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr concat-str      │ expression             │   78 │      0.02 │ ▏             │ ▁▁▁▁▁▁▁▇▁▁▁▁▁▁█▁▁▁▄▅▃▁▇▁ │         0.04 │ ▊                │ █▃▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr concatenate     │ dataframe              │   14 │      0.00 │               │ ▁▁▁▁▁▁▁▂▁▁▁▂▁▁▁▁▁▁▁▂▁▁█▁ │         0.02 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr contains        │ dataframe              │   21 │      0.00 │               │ ▁▁▁▁▁▁▁▁▄▁▁█▂▁▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▎               │ ▂▁▁▁▁▁▁▁▁▁▁█▁▁▁ │
│ dfr count           │ expression             │   54 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▂▁█▁▁▁▁▇▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr count-null      │ dataframe              │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr cumulative      │ dataframe              │    6 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │      ❎      │        ❎        │       ❎        │
│ dfr drop            │ dataframe              │  130 │      0.03 │ ▎             │ ▁▁▁▁▁▁▁▁▁▁▂█▁▁▂▂▁▁▁▁▁▂▁▁ │         0.07 │ █▏               │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr drop-duplicates │ dataframe              │   22 │      0.00 │               │ ▁▁▁▁▁▁▁▅▁▁█▁▁▁▆▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr drop-nulls      │ dataframe              │   11 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▁▁▁▁█▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr dtypes          │ dataframe              │   43 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▂▂▂▁▁▁▅▁▁▁█▂▃▃ │         0.03 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr dummies         │ dataframe              │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁█▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr explode         │ lazyframe              │    8 │      0.00 │               │ ▁▁▁▁▁▁▁█▆▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr expr-not        │ expression             │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▆▁▁█▁▁▃█▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr fetch           │ lazyframe              │   52 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▂▃▂█▆▁▁▁▁▂▁▁▁ │         0.03 │ ▌                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr fill-nan        │ lazyframe              │    7 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁█▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr fill-null       │ lazyframe              │   38 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▃▁▁▁▇▁▁▁▁▄▁▁▁█▁▂▂ │         0.03 │ ▌                │ █▆▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr filter          │ lazyframe              │  170 │      0.04 │ ▍             │ ▁▁▁▁▁▁▁▁▁▂▃▂▂▁█▂▁▁▁▂▁▁▁▁ │         0.11 │ █▊               │ ▄▂▁▁▁▁▁▁▁▁▁█▁▁▁ │
│ dfr filter-with     │ dataframe or lazyframe │  275 │      0.06 │ ▋             │ ▁▁▁▁▁▁▁▁▂▅▃▄█▃▂▂▁▁▁▂▂▃▁▂ │         0.12 │ █▉               │ ▇█▁▁▁▁▁▁▁▁▁▆▁▁▁ │
│ dfr first           │ dataframe              │   76 │      0.02 │ ▏             │ ▁▁▁▁▁▁▁▃▁▄█▆▁▁▃▃▁▂▃▁▁▁▁▁ │         0.04 │ ▋                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr flatten         │ lazyframe              │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr get             │ dataframe              │  123 │      0.03 │ ▎             │ ▁▁▁▁▁▁▁▁▁█▃▅▁▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▌               │ ▅█▁▁▁▁▁▁▁▁▁█▁▁▁ │
│ dfr get-nanosecond  │ dataframe              │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr group-by        │ lazyframe              │   79 │      0.02 │ ▏             │ ▁▁▁▁▁▁▁▄▁█▃▁▁▁▇▁▁▁▃▂▁▁▁▁ │         0.07 │ █▏               │ ▅▅▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr into-df         │ dataframe              │ 1098 │      0.23 │ ██▍           │ ▁▁▁▁▁▁▁▂▂▁▃▄▄▂█▅▅▁▂▃▂▁▂▂ │         0.17 │ ██▊              │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr into-lazy       │ lazyframe              │  231 │      0.05 │ ▌             │ ▁▁▁▁▁▁▁▂▁▃▃█▂▁▁▂▁▁▁▃▁▁▂▁ │         0.09 │ █▌               │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr into-nu         │ dataframe              │  436 │      0.09 │ ▉             │ ▁▁▁▁▁▁▁▁▁▃▂▆▄▁▃▄█▂▄▂▃▅▁▁ │         0.09 │ █▌               │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr is-duplicated   │ dataframe              │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr is-in           │ expression             │   41 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▆▁▄▁▁█▁▁▁▄▁▁▁▁ │         0.03 │ ▌                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr is-not-null     │ dataframe              │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr is-null         │ dataframe              │   18 │      0.00 │               │ ▁▁▁▁▁▁▁▂▁▅▂▂▁▃▁▁▁▁▁▂▁█▁▁ │         0.02 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr is-unique       │ dataframe              │    4 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▃▁▁▁█▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr join            │ lazyframe              │  250 │      0.05 │ ▌             │ ▁▁▁▁▁▁▁▂▁▃▂▃▂▂█▆▃▁▁▃▃▂▁▁ │         0.08 │ █▎               │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr last            │ dataframe              │   10 │      0.00 │               │ ▁▁▁▁▁▁▁▁▆▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr lit             │ expression             │   55 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▃▁▃▁ │         0.03 │ ▌                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr ls              │ dataframe              │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁█▁▁▁▁▅▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr max             │ expression             │   31 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▄▁▁▁ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr melt            │ dataframe              │    8 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▆█▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr min             │ expression             │   24 │      0.01 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▂▃▁▁▁▁ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr n-unique        │ dataframe              │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr not             │ dataframe              │   45 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▆█▃▅▇▁▁▁▄▃▄▁▁ │         0.04 │ ▋                │ █▅▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr open            │ dataframe              │  157 │      0.03 │ ▍             │ ▁▁▁▁▁▁▁▃▁█▂▁▅▂▂▁▁▁▁▆▁▁▁▂ │         0.24 │ ███▉             │ ▁▂▁▁▁▁▁▁▁▁▁▁▁▁█ │
│ dfr otherwise       │ expression             │   12 │      0.00 │               │ ▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr rename          │ dataframe or lazyframe │  191 │      0.04 │ ▍             │ ▁▁▁▁▁▁▁▁▁▂▂█▂▁▂▃▁▁▂▁▁▁▁▁ │         0.08 │ █▍               │ ██▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr replace         │ dataframe              │   10 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▂▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr replace-all     │ dataframe              │    4 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▅▅▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr reverse         │ lazyframe              │   15 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▆▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │ ▆█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr select          │ lazyframe              │  348 │      0.07 │ ▊             │ ▁▁▁▁▁▁▁▅▁▂▂▂▄▁▆█▄▁▁█▄▃▁▁ │         0.10 │ █▌               │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr set             │ dataframe              │   44 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁█▁▂▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │ █▇▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr shape           │ dataframe              │   44 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▃▁▁▁█▅▁█▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │ ██▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr shift           │ dataframe or lazyframe │    4 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │      ❎      │        ❎        │       ❎        │
│ dfr sort-by         │ lazyframe              │  227 │      0.05 │ ▌             │ ▁▁▁▁▁▁▁▃▃██▇▅▂▄▁▁▁▁▁▁▄▁▁ │         0.11 │ █▊               │ ▇█▁▃▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr str-lengths     │ dataframe              │   20 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▇▁▁▁▁ │         0.02 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr str-slice       │ dataframe              │   38 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁█▁▁▁▁ │         0.03 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr sum             │ expression             │   16 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁█▄▁▂▁▃▁▁▁▁▁▁▁▁▁ │         0.02 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr summary         │ dataframe              │    7 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▆█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr take            │ dataframe              │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▂█▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr to-arrow        │ dataframe              │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr to-csv          │ dataframe              │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁█▃▁▆▁▁▁▁▁█▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr to-parquet      │ dataframe              │    6 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁█▁▆▁▁▁▁▁▁▃▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr unique          │ dataframe or lazyframe │  170 │      0.04 │ ▍             │ ▁▁▁▁▁▁▁▃▁▂▃▆▁▁▅█▃▁▁▅▃▁▁▁ │         0.07 │ █▏               │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr value-counts    │ dataframe              │   56 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▃█▅▁██▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │ ▅█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr var             │ expression             │    6 │      0.00 │               │ ▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr when            │ expression             │   30 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁█▁▂▁▂▁▁▁▁▁▁▁▁▁▁▁▁ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ dfr with-column     │ dataframe or lazyframe │  388 │      0.08 │ ▉             │ ▁▁▁▁▁▁▁▃▁▂▂█▂▂▇▂▁▁▂▄▄▁▄▃ │         0.10 │ █▋               │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ do                  │ core                   │  249 │      0.05 │ ▌             │ █▁▅▂▃▂▅▁▂▁▁▂▂▁▂▁▂▂▁▄▁▁▁▂ │         0.28 │ ████▌            │ ▃▃▃▂▂▁▂▁▄▁▄▁▂█▁ │
│ drop                │ filters                │   76 │      0.02 │ ▏             │ ▄▂▃█▁▁▁▁▁▁▁▁▁▂▁▁▁▄▅▁▁▁▁▄ │         0.13 │ ██               │ ▂▂▁█▁▁▁▂▁▁▁▁▁▁▁ │
│ drop column         │ filters                │    2 │      0.00 │               │ ▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ drop nth            │ filters                │    4 │      0.00 │               │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ du                  │ core                   │   15 │      0.00 │               │ ▁▁▁▁▁▁█▆▁▅▃▁▃▁▁▁▁▃▁▆▁▁▁▁ │         0.11 │ █▊               │ ▁▁▂▃▁▂▁▁▁▁█▁▁▁▁ │
│ each                │ filters                │ 1915 │      0.41 │ ████▏         │ ▂▂▂▂▂▃▃▃▅▃▂▃▃█▁▁▂▂▃▅▂▃▄▂ │         0.47 │ ███████▌         │ ██▅▇▃▁▂▂▂▁▄▃▃▁▁ │
│ echo                │ core                   │  254 │      0.05 │ ▌             │ ▂█▆▂▂▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁ │         0.40 │ ██████▍          │ ▂▃▃▂▂▁▁▂▃▁▅▁▁█▇ │
│ encode              │ strings                │   17 │      0.00 │               │ ▁▁▁▁▄▁▁▂▁▁▁▁▁▁▁▁▁█▁▁▁▁▂▁ │         0.26 │ ████▎            │ ▁▁▁▄▁▁▁▁▁▁▁█▁▁▁ │
│ encode base64       │ hash                   │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ enumerate           │ filters                │  158 │      0.03 │ ▍             │ ▁▁▁▁▁▁▂▂▄▂▃▁▂▁▅▂▂█▁▄▁▃▁▃ │         0.10 │ █▋               │ █▅▄▁▃▁▁▁▁▁▁▁█▁▁ │
│ error make          │ core                   │   14 │      0.00 │               │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▅▆▁▃▁ │         0.14 │ ██▎              │ ▁▁▂▂▁▁▁▁▁▁▅▁█▁▁ │
│ exec                │ system                 │   15 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁█▁▂▁▂▁▁▁▁▁▁▁▁▁▁ │         0.11 │ █▊               │ ▁▂▁▁▂▁▁▁▁▁▁▁▁█▁ │
│ exit                │ shells                 │  163 │      0.03 │ ▍             │ ▄▂▂▅▄▄▁▂▁▅█▆▁▃▄▄▅▃▇▆▂▂▂▁ │         0.22 │ ███▌             │ ▂▁▁▂▁▁▅█▁▁▁▅▁▁▁ │
│ explain             │ debug                  │   27 │      0.01 │               │ ▁▁▁▁▁▁▄▁▁▂▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │ ▄█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ explore             │ viewers                │  100 │      0.02 │ ▎             │ ▁▁▆▄▃▂▁▄▇▁▁▂▁▃▂█▂▁▂▁▁▁▂▂ │         0.17 │ ██▊              │ ▂▃▆▁▂▁█▁▁▁▇▁▁▁▁ │
│ export              │ core                   │    2 │      0.00 │               │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▌               │ ▁▁▁█▁▄▁▁▁▁▁▁▁▁▁ │
│ export alias        │ core                   │    1 │      0.00 │               │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │ █▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ export def          │ core                   │   17 │      0.00 │               │ ▁▂█▂▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▂ │         0.18 │ ██▉              │ ▃▂▁▂▁▁▁▁▁▁▁▁█▁▁ │
│ export def-env      │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.06 │ █                │ ▂▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ export-env          │ env                    │    5 │      0.00 │               │ ▁█▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▊                │ ▃▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ fill                │ conversions            │   74 │      0.02 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▄▁▁▁▁▁▁▁▁ │         0.15 │ ██▍              │ ▂▂▁▁▁▁▁▁▁▁█▁▁▁▁ │
│ filter              │ filters                │  100 │      0.02 │ ▎             │ ▁▁▂▁█▂▁▂▆▅▅▁▄▃▁▁▂▂▇▂▁▁▁▁ │         0.17 │ ██▊              │ ▂▁▂▂▂▂▅▁█▁▁▁▄▁▁ │
│ find                │ filters                │  151 │      0.03 │ ▍             │ ▁▁▁▂▁▁▁▂▁▁█▃▁▃▁▁▁▁█▅▅▂▄▂ │         0.31 │ ████▉            │ ▂▂▃▄▃▁▁▁▂▂▂▁▂▃█ │
│ first               │ filters                │ 1574 │      0.33 │ ███▍          │ ▂▃▁▁▃▇▂▆▆▅▅█▄▂▃▅▇▃▃▄▂▁▁▁ │         0.34 │ █████▌           │ ▆█▃▁▁▁▃▂▂▁▂▁▁▁▁ │
│ flatten             │ filters                │  810 │      0.17 │ █▊            │ ▁▁▂▁▂▃▂▁█▃▃▁▁▃▁▁▁▁▂▁▁▃▄▂ │         0.28 │ ████▌            │ ██▅▅▃▃▁▂▁▁▆▁▅▁▁ │
│ for                 │ core                   │   64 │      0.01 │ ▏             │ ▁▅▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▃▂▁▁▁▁ │         0.19 │ ███              │ ▂▂▄▂▃▁▁▄▁▄█▁▂▁▁ │
│ format date         │ date                   │   15 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁█ │         0.04 │ ▋                │ █▁▁▁▁▁▁▁▁▁▁▁▆▁▁ │
│ format duration     │ strings                │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ from                │ formats                │    3 │      0.00 │               │ ▁▁▅█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.25 │ ████             │ ▁█▂▂▁▂█▂▁▁▂▁▁▁▁ │
│ from csv            │ formats                │  101 │      0.02 │ ▎             │ ▁▂▁▁▁▁▁▁▁▆▁▁▁▁▁▁▁▁▁▂▁█▂▁ │         0.12 │ ██               │ ▂▂▂▁▁▂█▁▁▁▁▁▁▁▁ │
│ from json           │ formats                │  849 │      0.18 │ █▊            │ ▃▄█▂▆▇▇▂▃▂▁▁▁▁▂▂▆▂▂▂▄▄▂▁ │         0.30 │ ████▊            │ ▆▇▃▁▄▃▂▁▁▁█▁▁▁▁ │
│ from nuon           │ formats                │   32 │      0.01 │ ▏             │ ▁▁▃▁▁▁▁▁▁▂▁▁▁▁▁█▁▁▁▁▃▂▁▁ │         0.10 │ █▋               │ ▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │
│ from toml           │ formats                │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ from tsv            │ formats                │   56 │      0.01 │ ▏             │ ▁█▁▁▁▁▁▁▁▁▁▁▄▁▁▂▃▁▄▁▁▁▂▁ │         0.15 │ ██▍              │ ▁▂▁▁▁▁▁▁▁▁█▁▁▁▁ │
│ from xml            │ formats                │   20 │      0.00 │               │ ▁▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁ │         0.11 │ █▊               │ ▁▁▁█▂▁▁▁▁▁▁▁▁▁▁ │
│ from yaml           │ formats                │  184 │      0.04 │ ▍             │ ▁▁▁▁▁▁▁▁▁▁▂▅▁▃▁▁▂█▄▅▁▁▁▂ │         0.07 │ █▏               │ █▄▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ get                 │ filters                │ 4702 │         1 │ ██████████    │ ▁▂▂▃▃▅▄▄█▂▃▃▄▄▁▂▃▄▁▄▁▂▂▂ │         0.74 │ ███████████▉     │ ██▅▆▄▃▁▁▂▁▃▂▃▂█ │
│ glob                │ filesystem             │  439 │      0.09 │ ▉             │ ▁▁▁▁▂▁▂▁▁▁▄▂▂▆▂▁▁▁▂▂▃▂█▅ │         0.14 │ ██▏              │ █▅▄▁▃▂▁▁▁▁▁▁▁▁▁ │
│ grid                │ viewers                │   19 │      0.00 │               │ ▁▂▂▅▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.04 │ ▋                │ ▂▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ group               │ filters                │    1 │      0.00 │               │ ▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │ ▁▁▆▁▁█▁▁▁▁▁▁▁▁▁ │
│ group-by            │ filters                │  307 │      0.07 │ ▋             │ ▁▂▁▂▁▄▂▃▁▂▃▁▁▃▁▁▁▂▁▁▁▇█▃ │         0.16 │ ██▋              │ ▅▄▅█▁▂▁▁▁▁▁▁▁▁▁ │
│ hash md5            │ hash                   │    7 │      0.00 │               │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁██▁▁▁▅▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ hash sha256         │ hash                   │   27 │      0.01 │               │ ▃▅▁▁▁▁▁▁▁▁▁▁▅▁▆▂▁▁▁█▁▁▂▁ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ headers             │ filters                │   44 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▄▁ │         0.06 │ ▉                │ ▇█▇▁▁▁▁▁▁▁▁▁▅▁▁ │
│ help                │ core                   │  794 │      0.17 │ █▊            │ ▅███▄▃▂▄▂▂▂▂▂▃▃▂▁▂▅▂▃▁▁▁ │         0.69 │ ███████████      │ ▂▃▅▃▂▂▂▁▃▁█▁▁▇█ │
│ help aliases        │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ help commands       │ core                   │   97 │      0.02 │ ▎             │ ▁▂▁▁▁▂▁▁▁▁▆▂▁▁▁▁▁▁▂▁▂▁█▂ │         0.16 │ ██▌              │ ▃▂█▃▁▂▄▁▁▁▁▇▁▁▁ │
│ help externs        │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ help modules        │ core                   │    3 │      0.00 │               │ ▁▁▁▁▁▁█▁▁▁▁▁▁██▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ help operators      │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ hide                │ core                   │    4 │      0.00 │               │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │ ▁▁▅█▁▁▁▁▁▁▁▁▁▁▁ │
│ histogram           │ chart                  │   11 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁█ │         0.07 │ █▏               │ ▁▁▂█▁▁▁▁▁▁▁▁▁▁▁ │
│ history             │ misc                   │  476 │      0.10 │ █             │ ▁▁▁▁▂▂▂▃▂▁▅▅▃▅▂▆▂▅█▂▁█▃▂ │         0.21 │ ███▍             │ ▆██▂▃▁▁▁▁▂▅▁▁▁▁ │
│ history session     │ misc                   │   18 │      0.00 │               │ ▁▁▁▁▅█▁▆▁▁▁▁█▁▆▁▃▃▁▁▁▁▁▁ │         0.03 │ ▌                │ ▇█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ http get            │ network                │  142 │      0.03 │ ▎             │ ▁▁▁▁▁▁▂▁▃▃▂▁▁▂▁▂▁█▁▂▆▂▅▄ │         0.25 │ ████             │ ▂▁▃▁▃▂█▁▁▁▁▁▁▆▁ │
│ http post           │ network                │   20 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁█▁▁ │         0.05 │ ▊                │ ▃▁▁▁▁▁█▁▁▁▁▁▁▁▁ │
│ if                  │ core                   │  490 │      0.10 │ █             │ ▂▂▄▂▅▁▁▂▅▄▂▂▁▂█▂▆▃▆▃▂▄▂▂ │         0.41 │ ██████▋          │ ▃▂▂▂▁▁▁▁▁▁▂▁█▁▁ │
│ ignore              │ core                   │    4 │      0.00 │               │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.13 │ ██▏              │ ▁▂▁▁▂▁▁▁▁▁▁▁▁█▁ │
│ input               │ platform               │   14 │      0.00 │               │ ▁▁▁▇▁▁▁█▁▁▄▁▁▁▂▁▁▁▁▁▁▁▄▁ │         0.15 │ ██▍              │ ▁▁▂▁▂█▁▁▁▂▁▁▁▁▁ │
│ input list          │ platform               │   22 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▄▂▁▅▁▁▁▆ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ insert              │ filters                │  136 │      0.03 │ ▎             │ ▁▂▁▂▁▁▁▁▁▁▁█▁▆▁▁▁▁▁▂▁▁▁▁ │         0.12 │ ██               │ ▆▇▁▇▁▅▁▁▁▃▁▁█▁▁ │
│ inspect             │ debug                  │   80 │      0.02 │ ▏             │ ▁▁▁▁▃▁▂▁▃▃▇▃▁█▁▁▂▁▂▄▁▁▁▂ │         0.09 │ █▍               │ ▅▆▆▁▁▁▁▁█▁▁▁▁▁▁ │
│ into                │ conversions            │   54 │      0.01 │ ▏             │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.16 │ ██▋              │ ▁▁▃▂▁▁▁▁▁▁█▁▁▁▁ │
│ into binary         │ conversions            │   41 │      0.01 │ ▏             │ ▁▁▁▁█▁▅▂▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.12 │ █▉               │ ▂▂█▁▁▁▁▁▁▁▁▅▁▁▁ │
│ into datetime       │ conversions            │  200 │      0.04 │ ▍             │ ▃▁▁▁▂▃▃▂▁▁▂▁▂▁▁▁█▁▁▁▁▁▁▂ │         0.14 │ ██▏              │ ▄▄█▁▁▁▂▁▁▁▁▁▁▁▁ │
│ into decimal        │ conversions            │   13 │      0.00 │               │ ▂▁▂▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │ ▂▁▂█▁▁▁▁▁▁▁▁▂▁▁ │
│ into duration       │ conversions            │    6 │      0.00 │               │ ▁▁▁▁█▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.06 │ █                │ ▁▁█▁▁▁▁▁▁▁▁▁▂▁▁ │
│ into filesize       │ conversions            │    5 │      0.00 │               │ ▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▍                │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ into int            │ conversions            │  341 │      0.07 │ ▊             │ ▃▁▃▁▅█▃▃▂▂▂▁▂▂▁▃▂▁▁▁▁▂▁▅ │         0.17 │ ██▊              │ ▆█▇▃▁▂▃▁▁▁▁▁▃▁▁ │
│ into record         │ conversions            │   84 │      0.02 │ ▏             │ ▁▁▁▂▂█▅▁▃▃▁▁▁▁▁▁▇▁▂▂▁▁▂▁ │         0.12 │ █▉               │ ▄▅▇▁▄▁▁▁█▁▁▁▃▁▁ │
│ into string         │ conversions            │  109 │      0.02 │ ▎             │ ▃▂▂▁▁▁▁█▂▄▁▁▁▁▁▁▁▁▁▁▁▁▁▂ │         0.10 │ █▌               │ ▇█▅▁▁▁▁▁▁▁▁▁▂▁▁ │
│ is-empty            │ filters                │   59 │      0.01 │ ▏             │ ▁▁▆▁▂▁▂▁▁▁▁▁▁▂▁▁▂▁█▁▁▁▁▁ │         0.23 │ ███▊             │ ▂▁▁▁▁▁▁▁▁▁▂▁█▁▁ │
│ items               │ filters                │  178 │      0.04 │ ▍             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▂▂▂▂▁█▅▁ │         0.10 │ █▌               │ ▆▁▂▁▃▁█▁▁▁▁▁▁▁▁ │
│ join                │ filters                │    9 │      0.00 │               │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │ ▂▆█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ keybindings         │ platform               │    6 │      0.00 │               │ ▁▁▅▁▁▁▁▁█▁▁▁▁▅▁▁▁▁▅▁▅▁▁▁ │         0.08 │ █▎               │ ▁▅█▁▃▁▁▁▁▁▁▁▁▁▁ │
│ keybindings default │ platform               │    8 │      0.00 │               │ ▁▁█▁▁▅▁▁██▁▅▁▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ keybindings list    │ platform               │   10 │      0.00 │               │ ▁▁▅▁▁▅▅▅█▅▅▁▁▁▁▁▁▁▁▅▅▁▁▁ │         0.03 │ ▌                │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ keybindings listen  │ platform               │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▃▆█▁▁▁▁▁▁▁▃▆▁▁▁▁ │         0.04 │ ▊                │ ▂▁█▁▆▁▁▁▁▁▁▁▁▁▁ │
│ last                │ filters                │  662 │      0.14 │ █▍            │ ▁▁▁▁▅▂▁▁▁▂▂▁█▅▂▅▃▄▂▂▁▃▂▂ │         0.24 │ ███▉             │ ▆▅▄█▄▁▃▁▁▁▁▁▁▁▁ │
│ lazy make           │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ length              │ filters                │ 1018 │      0.22 │ ██▏           │ ▂▁▁▂▁▂▂▃▃█▅▅█▂▂▂▃▁▂▃▃▃▁▁ │         0.28 │ ████▌            │ ▇█▃▃▂▁▁▁▁▁▂▁▃▁▁ │
│ let                 │ core                   │ 2269 │      0.48 │ ████▉         │ ▁▂▄▄▆▆▄▃▅▆▇▅▅▁▄▂▃▂▃▄▁▂▄█ │         0.57 │ █████████▏       │ █▆▅▃▂▁▁▁▃▁▂▂▇▃▁ │
│ let-env             │ removed                │  117 │      0.02 │ ▎             │ ▁▃▂▁▁▁▂▁▁▁▁▁▂▁█▁▁▁▂▁▁▁▁▁ │         0.26 │ ████▎            │ ▂▂▄▅▂▁▂▁█▁▁▁▁▆▁ │
│ lines               │ filters                │  636 │      0.14 │ █▍            │ ▁▂▂▃▂▁▂▁▆▂▂▃▃▁▁▁▃█▁▂▂▄▂▁ │         0.38 │ ██████▏          │ ▆▅▆▇█▂▆▃█▂▆▃▂▁▁ │
│ ls                  │ filesystem             │ 3327 │      0.71 │ ███████▏      │ ▁▄▂▁▂▁▃█▅▄▃▂▅▂▃▃▃▁▃▆▃▂▁▂ │         1.00 │ ████████████████ │ ▆▆███▄▄██▁▆█▁▆▇ │
│ match               │ core                   │   21 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▃▂▂▁▁▂▁▂▂ │         0.08 │ █▎               │ ▂▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ math avg            │ math                   │    6 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▂ │         0.09 │ █▍               │ ▁▁▁█▁▁▁▁▁▁▁▁▂▁▁ │
│ math ceil           │ math                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.03 │ ▌                │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math floor          │ math                   │   30 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │ ▅█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math log            │ math                   │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math max            │ math                   │   42 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄▁▁▁▇▁▁█▄ │         0.03 │ ▌                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math median         │ math                   │    6 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▂ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math min            │ math                   │   28 │      0.01 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁█▁▁▄▄ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math round          │ math                   │   33 │      0.01 │ ▏             │ ▁▁▇▁▁▁▁▁▁▁▃▁▅▂▁▂▁▁▁▁▁▁▆█ │         0.04 │ ▋                │ █▅▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math sqrt           │ math                   │   16 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ math sum            │ math                   │  122 │      0.03 │ ▎             │ ▁▁▂▁▁▃▁▁▁▁▆▁▅▂▁▁▂▁▁▁▁▁▆█ │         0.09 │ █▌               │ ▅▅▃█▁▁▁▁▁▃▁▁▁▁▁ │
│ merge               │ filters                │  308 │      0.07 │ ▋             │ ▁▃▁▁▁▅▃▃▁▃▁▁▂▂▂▁▂▁▂▂▁▁█▃ │         0.21 │ ███▍             │ ▄▄█▄▂▄▁▃▁▁▁▁▂▁▁ │
│ metadata            │ debug                  │   10 │      0.00 │               │ ▁▁▁▁▁▁▁▅▁▁▁▁▁▁▁▁▁▁▁▁█▁▂▁ │         0.18 │ ██▉              │ ▁▁▁▁▁▃▁▁▁▁▃▁█▁▁ │
│ mkdir               │ filesystem             │   92 │      0.02 │ ▎             │ ▂▅▃▃█▁▂▅▃▄▄▂▄▃▂▆▂▂▁▅▃▂▁▂ │         0.20 │ ███▎             │ ▂▃▂▄▄▄▃▁▄▁█▁▁▁▁ │
│ module              │ core                   │    5 │      0.00 │               │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁▁▁▁ │         0.11 │ █▊               │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ move                │ filters                │   73 │      0.02 │ ▏             │ ▁▁▁▁▁▃▁▁▁▃▁▃▁▁▂▃▅▁▁▁▁▁█▁ │         0.07 │ █▏               │ █▆▁▁▆▁▁█▁▁▁▁▁▁▁ │
│ mut                 │ core                   │   83 │      0.02 │ ▏             │ ▁▁█▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁▄▃▁▁▁▁ │         0.15 │ ██▍              │ ▃▃▃▅▂▁▁▁▁▁▁▁█▁▁ │
│ mv                  │ filesystem             │  162 │      0.03 │ ▍             │ ▁▃▁▁▂▁▂▃▂▂▃▂▂▃▃▇▂▃▄█▃▃▂▂ │         0.21 │ ███▍             │ ▃▂▂▅▇▅▂▄█▁▁▁▁▁▁ │
│ nu-check            │ strings                │    8 │      0.00 │               │ ▁▁▅█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▁▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ nu-highlight        │ strings                │   11 │      0.00 │               │ ▁▁▆▁▁▁▁█▁▁▁█▁▁▁█▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │ ▂▁▂█▁▁▁▁▁▁▁▁▆▁▁ │
│ open                │ filesystem             │ 3148 │      0.67 │ ██████▊       │ ▁▂▃▂▃▂▃▇█▄▂▃▅▅▂▁▁▃▂▃▁▁▂▁ │         0.72 │ ███████████▌     │ ▆█▄▄▄▃▆▂▂▁▃▃▁▂▇ │
│ overlay             │ core                   │    8 │      0.00 │               │ █▄▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.23 │ ███▋             │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ overlay hide        │ core                   │   46 │      0.01 │ ▏             │ ▂█▃▁▁▁▄▄▁▂▂▁▁▃▁▁▁▁▁▁▁▁▁▁ │         0.07 │ █▏               │ ▄▇▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ overlay list        │ core                   │   29 │      0.01 │               │ ▅█▃▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │ ▂▃▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ overlay new         │ core                   │    3 │      0.00 │               │ █▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │
│ overlay use         │ core                   │  572 │      0.12 │ █▎            │ ▂█▄▆▂▃▂▁▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.19 │ ███              │ ▅█▁▃▁▁▁▁▁▁▁▁▁▁▁ │
│ par-each            │ filters                │  413 │      0.09 │ ▉             │ ▁▁▅▁▁▂▁▃▅▆█▅▃▁▂▁▄▁▂▂▁▂▁▄ │         0.15 │ ██▍              │ ▅█▁▁▁▁▁▁▁▁▁▁▂▁▁ │
│ parse               │ strings                │  513 │      0.11 │ █▏            │ ▂▃▃▇▂▁▁▁█▁▁▁▂▁▁▂▂▂▁▁▁▁▁▁ │         0.22 │ ███▌             │ ▅█▄▂▄▁▂▂▁▁▁▁▁▁▁ │
│ path basename       │ path                   │  100 │      0.02 │ ▎             │ ▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▄▅ │         0.07 │ █▏               │ ▇█▁▁▆▁▁▁▁▁▁▁▁▁▁ │
│ path dirname        │ path                   │   10 │      0.00 │               │ ▁▁▁▁▁▁▁▃▁▁█▅▁▁▁▅▁▁▁▁▃▁▁▁ │         0.07 │ █▏               │ ▂▁▃▁▁▁▁▁█▁▁▁▂▁▁ │
│ path exists         │ path                   │   32 │      0.01 │ ▏             │ ▁▄▂▃▁▁▃▂▁▂▁▁▁▁▁▁▂▁▁▂▃█▁▁ │         0.06 │ █                │ █▄█▁▆▁▁▁▁▁▁▁▄▁▁ │
│ path expand         │ path                   │   39 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁█▂▁▁▃▁▅▁▁▁▁▁▁▂▁▁▁ │         0.14 │ ██▎              │ ▂▂▃▂▆▁▁█▁▁▁▁▂▁▁ │
│ path join           │ path                   │   10 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁▁▁▁▁█▁▁▁ │         0.14 │ ██▏              │ ▂▁▃▅▇▁▁▃▁▁█▁▄▁▁ │
│ path parse          │ path                   │   55 │      0.01 │ ▏             │ ▁▁▁▂▁▁▁▁▄▁▁▂█▁▁▁▁▁▄▁▁▁▁▁ │         0.12 │ ██               │ ▂▃▃▃▃▁▁▁▁▁█▁▂▁▁ │
│ path relative-to    │ path                   │    8 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.05 │ ▉                │ ▁▁▁▇█▁▁▁▁▁▁▁▁▁▁ │
│ path split          │ path                   │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │ ▁▁▁▁▇▁▁▁█▁▁▁▁▁▁ │
│ path type           │ path                   │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁██▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │ ▁▁▁▁█▁▁▁▁▁▁▁▃▁▁ │
│ prepend             │ filters                │   64 │      0.01 │ ▏             │ ▁▁▁▁▁▁▂▁▁▁▁▁▂▁▁▁▁█▆▅▁▁▁▂ │         0.13 │ ██▏              │ ▂▁▂▁▂▁▁▁▁▁▁▁▁█▁ │
│ print               │ strings                │  439 │      0.09 │ ▉             │ ▁▁█▂▁▁▂▂▂▂▃▃▆▃▁▃▂▂▂▄▁▁▃▃ │         0.31 │ ████▉            │ ▅▄▅▂▄▁▁▂█▁▃▂▂▆▁ │
│ profile             │ debug                  │   53 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▄█▁▁▁▂▆▁▃▁▁▁▁▁ │         0.32 │ █████▏           │ ▁▁▁█▂▁▁▁▁▁▁▁▁▆▁ │
│ ps                  │ system                 │   43 │      0.01 │ ▏             │ ▁▆▃▁▁▁▁▁▁▁▁▃▁▁▄▁█▁▂▁▇▁▂▄ │         0.31 │ ████▉            │ ▁▁▂▁▂▁▁▁▁█▂▁▁▅▁ │
│ random              │ random                 │    3 │      0.00 │               │ ▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.04 │ ▋                │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ random chars        │ random                 │   20 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▃▁ │         0.04 │ ▋                │ ▄▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ random dice         │ random                 │    6 │      0.00 │               │ ▁▅▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ reduce              │ filters                │  240 │      0.05 │ ▌             │ ▁▁▂▃▁█▄▂▂▂▂▂▁▁▅▁▂▂▁▁▁▁▄▂ │         0.13 │ ██▏              │ ██▆▁▃▁▁▁▁▁▁▁▄▁▁ │
│ register            │ core                   │   19 │      0.00 │               │ ▁▁▃▅▁█▂▁▁▁▁▁▂▁▁▁▁▁▁▁▁▁▁▁ │         0.18 │ ██▉              │ ▁▁▆▂▁▁█▁▁▁▁▆▁▁▁ │
│ reject              │ filters                │  463 │      0.10 │ █             │ ▁▁▁▁▁▁▁▁█▁▄▂▁▁▃▂█▁▁▁▁█▄▄ │         0.17 │ ██▋              │ █▆▄▄▃▁▂▃▁▁▁▁▃▁▁ │
│ rename              │ filters                │  251 │      0.05 │ ▌             │ ▁▂▁▁▅▁▅█▁▂▂▁▁▁▂▁▁▁▁▂▁▅▃▅ │         0.14 │ ██▎              │ ▇█▆▁▃▂▁▄▁▁▁▁▄▁▁ │
│ return              │ core                   │   21 │      0.00 │               │ ▁▁▁▁▁▁▁▇█▅▁▁▁▁▁▁▆▁▁▅▁▁▁▁ │         0.10 │ █▋               │ ▂▂▂▁▁▁▁▁▁▁▁▁█▁▁ │
│ reverse             │ filters                │  118 │      0.03 │ ▎             │ █▂▂▁▁▁▂▁▃▁▁▁▁▇▁▁▁▁▂▃▁▁▅▃ │         0.16 │ ██▋              │ ▂▅▂▁▁▁▁▁▁▁█▁▁▁▁ │
│ rm                  │ filesystem             │  197 │      0.04 │ ▍             │ ▃█▃▁▅▁▅█▃▇▄▆▆▃▄▆▃▁▁▆▄▃▁▂ │         0.40 │ ██████▍          │ ▂▂▂▃▅▃▃▃▅▁▂▂▁█▁ │
│ run-external        │ system                 │    2 │      0.00 │               │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁ │         0.15 │ ██▍              │ ▁▁▁▁▁▁▁▁▁▁▁▁▁█▁ │
│ save                │ filesystem             │  568 │      0.12 │ █▎            │ ▂▃▂▃▂▅▄█▅▅▂▂▂▁▁▁▂▃▅▂▂▃▃▁ │         0.26 │ ████▏            │ ▇█▃▃▅▂▄▂▂▁▅▃▁▁▁ │
│ schema              │ database               │    2 │      0.00 │               │ ▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.06 │ █                │ ▁▁█▁▁▇▁▁▁▁▁▁▁▁▁ │
│ scope               │ core                   │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.04 │ ▋                │ ▁▁▁▁▁█▁▁▁▁▁▁▁▁▁ │
│ scope variables     │ filters                │   54 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▁▁▁█ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ select              │ filters                │ 1047 │      0.22 │ ██▎           │ ▂▁▂▁█▄▄▅▅▂▃▁▁▆▁▁▂▁▁▆▁▁▃▃ │         0.33 │ █████▎           │ ▆█▅▁▂▅▃▄▁▁▁▂▂▁▁ │
│ seq                 │ generators             │   15 │      0.00 │               │ ▁▁██▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▁▁▁ │         0.07 │ █▏               │ ▅▃█▁▁▁▁▁▁▁▁▁▄▁▁ │
│ seq char            │ generators             │    4 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ seq date            │ generators             │   50 │      0.01 │ ▏             │ █▁▂▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▃ │         0.06 │ █                │ ▅██▁▁▁▁▁▁▁▁▁▁▁▁ │
│ size                │ strings                │    8 │      0.00 │               │ ▁▂▁▁█▁▁▁▁▁▁▁▂▂▁▁▁▁▁▁▁▁▁▁ │         0.16 │ ██▋              │ ▁█▆▆▂▂▁▁▁▁▁▄▁▁▁ │
│ skip                │ filters                │  337 │      0.07 │ ▊             │ ▁▁▁▁▁▃▂▄█▂▁▂▂▁▁▁▂▅▁▁▂▁▁▁ │         0.22 │ ███▌             │ ▅▇▄█▃▁▁▇▁▁▁▁▂▁▁ │
│ skip until          │ filters                │   87 │      0.02 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▅▂▁ │         0.06 │ ▉                │ █▁▁▁█▁▁▁▁▁▁▁▁▁▁ │
│ skip while          │ filters                │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ sleep               │ platform               │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁ │         0.07 │ █▏               │ ▁▁▆▁█▁▁▁▁▁▁▁▁▁▁ │
│ sort                │ filters                │   52 │      0.01 │ ▏             │ ▁▂▁▃▃▂▁▂▁▂▄▄▁▁▁█▂▁▁▄▁▁▃▄ │         0.07 │ █▏               │ ▄▁▁▁▁▇▁█▁▁▁▁▁▁▁ │
│ sort-by             │ filters                │  738 │      0.16 │ █▋            │ ▁▄▁▂▃▃▂▆▃▅▅▃█▂▂▁▇▂▁▃▂▂▁▃ │         0.30 │ ████▊            │ ▅▇▄▃▂▁▁▁▁▁▂▂▁▁█ │
│ source              │ core                   │ 1445 │      0.31 │ ███▏          │ ▇▅▄█▃▂▄▁▁▂▂▄▃▅▂▁▃▂▃▄▁▂▄▇ │         0.46 │ ███████▍         │ ▅▆▆▄▁█▂▁▂▆▁▁▁▄▁ │
│ split               │ strings                │    4 │      0.00 │               │ █▁▁▅▅▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ split chars         │ strings                │   53 │      0.01 │ ▏             │ ▁▁▁▁█▁▁▁▁▂▁▁▁▁▁▁▃▁▃▁▁▁▁▂ │         0.11 │ █▊               │ ▂▂▄▁▁▁▁▁▁▁▁█▁▁▁ │
│ split column        │ strings                │   35 │      0.01 │ ▏             │ ▁▁▁▁█▂▁▁▁▂▄▃▁▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │ ▂▂█▁▁▂▁▁▁▁▁▁▁▁▁ │
│ split list          │ filters                │    2 │      0.00 │               │ ▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ split row           │ strings                │  370 │      0.08 │ ▊             │ ▁▁▁█▂▁▁▁▁▁▁▁▂▃▁▁▁▁▁▁▁▁▂▁ │         0.20 │ ███▏             │ ▆▆▄▂▃▁▁▁▁▁▁▁▁█▁ │
│ split-by            │ filters                │    2 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │      ❎      │        ❎        │       ❎        │
│ start               │ filesystem             │   53 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▃█▂▅▂▄▃▂▂▁▃▃▂▃▄▃ │         0.15 │ ██▍              │ ▂▃▂▁▃▁█▃▁▁▁▁▁▁▁ │
│ str                 │ strings                │   43 │      0.01 │ ▏             │ ▂▁▂█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.05 │ ▉                │ ▆▁▁▁▁▇▁▁▁█▁▁▁▁▁ │
│ str capitalize      │ strings                │    6 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ str contains        │ strings                │   52 │      0.01 │ ▏             │ ▁▁▁▁█▁▁▁▁▁▁▂▁▁▁▁▂▁▁▁▁▁▁▁ │         0.10 │ █▋               │ ▂▃▁▁█▁▁▁▁▁▁▁▁▁▁ │
│ str distance        │ strings                │    2 │      0.00 │               │ ▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ str ends-with       │ strings                │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ str expand          │ strings                │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ str index-of        │ strings                │    4 │      0.00 │               │ ▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▃▁▁▁▁▁ │         0.01 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ str join            │ strings                │  281 │      0.06 │ ▋             │ ▁▂▁▅▃▂▃▁▆▁▃▁▄▃▁▂▂█▃█▁▄▂▂ │         0.25 │ ████             │ ▅▃▃▁▂▁▁▄▃▁▆▃█▁▁ │
│ str length          │ strings                │   76 │      0.02 │ ▏             │ ▂█▁▁▂▁▁▁▄▂▁▁▁▁▁▂▁▁▂▃▁▁▁▁ │         0.09 │ █▌               │ ▅▅█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ str replace         │ strings                │  831 │      0.18 │ █▊            │ ▁▂▂▄█▃▂▂▁▂▃▇▃▇▁▆▆▇▁▂▃▁▄▃ │         0.22 │ ███▋             │ █▇▅▁▃▁▃▁▂▁▁▁▁▁▁ │
│ str starts-with     │ strings                │   57 │      0.01 │ ▏             │ ▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▂▁▃▁▂▁▁▁ │         0.10 │ █▋               │ ▄▃▁▁▄▁▁▁▁▁█▁▃▁▁ │
│ str substring       │ strings                │  196 │      0.04 │ ▍             │ ▁▂▂▁▂▂▁▁▃▅▁█▂▂▁▁▂▁▁▁▁▁▁▆ │         0.13 │ ██▏              │ ▅▆▂▁▁▁▁▁▁▁█▁▂▁▁ │
│ str trim            │ strings                │   39 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁█▂▁▁▁▂▁▁▁▁▂▁▁▁▁▁▁ │         0.13 │ ██               │ ▃▃█▃▄▁▁▁▁▁▁▁▂▁▁ │
│ str upcase          │ strings                │   14 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▅▁▁▄▁▁▁▁█ │         0.03 │ ▍                │ ▄▁▁▁▁▁▁▁▁▁▁▁█▁▁ │
│ sys                 │ system                 │   32 │      0.01 │ ▏             │ ▁▆▂▁▁▁▁▁▁▁▁▁▁█▂▁▁▁▁▁▁▁▁▁ │         0.30 │ ████▉            │ ▁▁▁▁▁▁▁▁▂▁▂▁▁▁█ │
│ table               │ viewers                │  126 │      0.03 │ ▎             │ ▁▁▅▃█▃▁▂▃▂▂▂▂▁▁▁▁▁▁▁▂▄▁▁ │         0.31 │ ████▉            │ ▂▂▇▄▂▂▁▁▃▁▄▁▁▁█ │
│ take                │ filters                │    7 │      0.00 │               │ ▁▁▁▁▅▁▁▁▁▁▁▁▁▁▁▁▁█▃▁▁▁▁▁ │         0.07 │ █▏               │ ▁▁█▁▁▁▁▁▁▁▁▁▂▁▁ │
│ take until          │ filters                │   36 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁ │         0.03 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ term size           │ platform               │   31 │      0.01 │ ▏             │ ▁▁▄▄█▂▁▁▁▁▁▁▁▁▂▆▁▁▁▁▁▁▁▁ │         0.08 │ █▎               │ ▃▃█▁▁▅▁▁▁▁▁▁▁▁▁ │
│ timeit              │ debug                  │  349 │      0.07 │ ▊             │ ▁▁▁▁▁▁▁▃▁▄▄▅▃▁█▄▂▂▃▂▂▁▁▁ │         0.17 │ ██▊              │ ▅▃▂▁▃▂▁▁█▁▁▁▁▁▁ │
│ to                  │ formats                │    2 │      0.00 │               │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁ │         0.18 │ ███              │ ▁█▂▄▃▂▄▄▁▄▁▁▁▁▁ │
│ to csv              │ formats                │   85 │      0.02 │ ▏             │ ▁▁▁▁▁▁▁▁▁▃▁▄▄▅▁▆▇▄█▂▁▅▁▂ │         0.06 │ █                │ █▅▇▁▁▁▁▁▁▁▁▁▁▁▁ │
│ to json             │ formats                │  125 │      0.03 │ ▎             │ ▂▄▂▁▁▁▃▁▁▂▁▁▁▁▁▄█▁▆▅▃▃▁▁ │         0.12 │ █▉               │ ▄▂▆▁▂▁█▁▁▁▁▁▁▁▁ │
│ to md               │ formats                │   26 │      0.01 │               │ ▁▁█▁▂▁▁▂▁▂▁▁▃▂▁▁▁▁▁▁▂▁▃▂ │         0.08 │ █▎               │ ▃▄▄█▁▁▆▁▁▁▁▁▁▁▁ │
│ to nuon             │ formats                │   79 │      0.02 │ ▏             │ ▁▂▆▁▂▂▁▃▃▃▃▁▁▃▄█▃▃▁▁█▃▁▄ │         0.12 │ █▉               │ ▂▂▂▁▂▁▁▁▁▁█▁▁▁▁ │
│ to text             │ formats                │   48 │      0.01 │ ▏             │ ▁▁▁▂▁▁▁█▂▁▁▁▁▁▁▁▁▃▁▂▁▁▂▁ │         0.22 │ ███▌             │ ▁▂▃▁▄▁▄▁▄▁█▃▁▁▁ │
│ to toml             │ formats                │   30 │      0.01 │ ▏             │ ▁▁▁▁▁▁▁▁▁▃▁▁▃▁▁▁█▂▁▁▁▁▁▁ │         0.02 │ ▍                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ to tsv              │ formats                │   14 │      0.00 │               │ ▁▁▁▁▃▁▁▁▁▁▂▁▁▁█▁▁▁▁▄▁▁▁▁ │         0.04 │ ▋                │ ▃▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ to yaml             │ formats                │  552 │      0.12 │ █▏            │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▄█▂▂▂▂▂▁ │         0.10 │ █▋               │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ touch               │ filesystem             │   14 │      0.00 │               │ ▃█▁▁▁▅▃▁▃▁▁▅▅▁▁▁▁▁▁▁▁▁▁▃ │         0.05 │ ▊                │ ▂▄▁▁█▁▁▁▁▁▁▁▁▁▁ │
│ transpose           │ filters                │  400 │      0.09 │ ▉             │ ▁▁▃▁▃▅▂▂█▂▃▂▂▃▁▂▂▁▁▂▁▁▅▁ │         0.25 │ ████             │ ▅▇█▃▂▂▁▁▁▁▇▁▂▇▁ │
│ try                 │ core                   │   87 │      0.02 │ ▏             │ ▁▁▂▁▁█▁▅▅▃▅▂▁▃▄▁▆▁▄▁▂▄▁▁ │         0.20 │ ███▏             │ ▂▂▂▁▁▁▁▆▁▁▅▁▄█▁ │
│ tutor               │ misc                   │    3 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.07 │ █▏               │ ▁▂▁▁▁▁▁▁▁▁█▁▁▁▁ │
│ uniq                │ filters                │  310 │      0.07 │ ▋             │ ▁▁▁▁▂▆▄█▄▅▃▂▃▃▃▁▃▂▁▃▃▁▆▁ │         0.16 │ ██▋              │ ▆█▃▁▃▁▁▁▁▁█▁▁▁▁ │
│ uniq-by             │ filters                │    9 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▂▁▁▁▁ │         0.01 │ ▎                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ update              │ filters                │   12 │      0.00 │               │ ▁▁▁▁▁▂▁▁▁▅█▁▁▁▁▁▁▁▂▂▁▁▁▁ │         0.29 │ ████▋            │ ▁▂▅▆▄█▅▃▂▄▃▁▃▁▁ │
│ upsert              │ filters                │ 1749 │      0.37 │ ███▊          │ ▂▂▁▃▆▇▂▃█▄▄▂▂▆▂▂▅▁▃▂▂▁▆▅ │         0.28 │ ████▍            │ ██▃▁▁▁▁▁▁▁▁▁▁▁▁ │
│ url join            │ network                │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ use                 │ core                   │  232 │      0.05 │ ▌             │ ▂▅▁▁▁▁▁▁▁▁▂▁▁▅▅▂▂█▃▅▃▄▂▂ │         0.21 │ ███▍             │ ▃▂▂█▂▃▁▁▁▁▁▁▂▇▁ │
│ values              │ filters                │  191 │      0.04 │ ▍             │ ▁▁▁▁▂▂▁▂▁▁▃▁▁▂▁▁█▂▂▁▁▁▄▂ │         0.10 │ █▌               │ █▇▃▁▁▂▁▁▁▁▁▁▂▁▁ │
│ version             │ core                   │   61 │      0.01 │ ▏             │ ▁▁█▁▂▁▁▂▁▂▁▁▁▂█▂▆▂▂█▆▅▁▂ │         0.24 │ ███▉             │ ▁▁▂▂▂▂▁▁▃▁▃▂▁█▁ │
│ view                │ debug                  │    2 │      0.00 │               │ █▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.09 │ █▍               │ ▁▃▃█▁▅▁▁▁▁▁▁▁▁▁ │
│ view files          │ debug                  │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁█ │         0.03 │ ▌                │ ▁▁█▁▁▁▁▁▁▁▁▁▁▁▁ │
│ view source         │ debug                  │   76 │      0.02 │ ▏             │ ▁▁▁▂▁▁▄█▁▂▅▃▃▂▃▃▁▁▃▃▃▁▁▂ │         0.06 │ █                │ ██▁▁▁▁▁▁▁▁▁▁▆▁▁ │
│ view span           │ debug                  │    1 │      0.00 │               │ ▁▁▁▁▁▁▁▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ watch               │ filesystem             │    1 │      0.00 │               │ ▁▁▁█▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │         0.00 │ ▏                │ █▁▁▁▁▁▁▁▁▁▁▁▁▁▁ │
│ where               │ filters                │ 1328 │      0.28 │ ██▉           │ ▁▂▂▂▃▄▅█▇▂▄▁▃▄▂▁▃▁▁▃▃▂▄▄ │         0.47 │ ███████▌         │ ▆█▇▆▄▅▃▂▂▁▇▄▄▁▁ │
│ which               │ system                 │  304 │      0.06 │ ▋             │ ▁▁▆▃▂▁▂▂▁▅▂▁▁▁▃▁▄▁█▃▂▃▂▁ │         0.29 │ ████▋            │ ▂▂▂▂▃▁▂▁▄▁▁▂▁█▁ │
│ window              │ filters                │   41 │      0.01 │ ▏             │ ▂▁▆▂▁▁▁▁█▂▂▁▁▁▁▁▂▄▁▁▁▂▁▃ │         0.08 │ █▍               │ ▃█▆▁▆▁▁▁▁▁▁▁▁▁▁ │
│ wrap                │ filters                │  166 │      0.04 │ ▍             │ ▄█▁▅▇▅▂▆▁▁▁▁▃▁▁▁▁▁▁▆▄▁▁▃ │         0.11 │ █▊               │ ▆█▆▁▃▁▁▁▁▁▁▁▁▁▁ │
│ zip                 │ filters                │   14 │      0.00 │               │ ▅▄▅▁▁▁▂▁▁▁▁▁█▁▁▁▁▁▁▁▁▁▁▁ │         0.10 │ █▋               │ ▂█▇▆▅▁▇▁▁▁▁▁▄▁▁ │
╰────────name─────────┴────────category────────┴─freq─┴─freq_norm─┴─freq_norm_bar─┴─────────timeline─────────┴─users_c_rank─┴─users_c_rank_bar─┴─users_sparkline─╯


```

