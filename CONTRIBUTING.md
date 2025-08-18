# Contributing to Interfatecs Repo

Thanks for your interest in contributing!

## Structure Rules

All submissions must follow the repository's structure and naming conventions. To enforce this, we use a script that will run automatically when you submit a pull request.

Please make sure your submission passes the structure check locally before submitting a PR:

```bash
./scripts/validate_structure.bash
```

The following is a diagram of the rules enforced by the validation script:

```bash
├── YYYY_fase[1|2|-unica]
│   ├── Caderno_Questoes.pdf
│   ├── Estatisticas.pdf (optional)
│   ├── solutions (optional)
│   │   ├── *.[c|cpp|java|py|hs|js]
│   └── testset
│       ├── judge.sh
│       ├── a_problem1
│       │   ├──input
│       │   │   └──*
│       │   └──output
│       │       └──*
│       ├── b_problem2
│       │   ...
│       └── z_problem26
```

Where `YYYY >= 2012` is the competition year. Examples:
```
2019_fase1
```
```
2019_fase2
```
```
2020_fase-unica
```

`input` and `output` folders must have same number of files, and each file in `input` must map correctly to a file in `output` through the corresponding loop in `judge.sh` script.
