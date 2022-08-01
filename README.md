# DerpyCoder

To begin:
* Install brew
* Install asdf
* brew install go-task/tap/go-task

* task install.asdf
* task install.tools
* task install.deps

* task start.postgres
* task seed.db
* task start.server

> Install DBeaver for inspecting the database.

For more commands:
* mix help
* task -l

Global Env Variables:
* source $(brew --prefix asdf)/libexec/asdf.sh
* export ELIXIR_EDITOR="code --goto __FILE__:__LINE__"

> Must have installed `code` command in path, for file to open in VS Code!!

## Icon:
- [HeroIcons](https://heroicons.com)
- [SVG OMG](https://jakearchibald.github.io/svgomg/)

## To Add:
- [ ] Instruction for installing Postgres
- [ ] Later clickhouse

## Fix:
- [ ] To test: `mix test`
- [ ] mix test --cover --export-coverage default
- [ ] mix test.coverage
- [ ] mix test —cover
