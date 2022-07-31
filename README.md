# DerpyCoder

To begin:
* brew install go-task/tap/go-task
* task install.tools
* task install.deps
* task start.server

> Pre requisites: Brew & ASDF must be installed along with latest Postgres version.
> DBeaver is nice to have as well.

For more commands:
* mix help
* task -l

Global Env Variables:
* source $(brew --prefix asdf)/libexec/asdf.sh
* export ELIXIR_EDITOR="code --goto __FILE__:__LINE__"

> Must have installed `code` command in path, for file to open in VS Code!!

## To Add:
- [ ] Instruction for installing Postgres
- [ ] Later clickhouse

## Fix:
- [ ] To test: `mix test`
- [ ] mix test --cover --export-coverage default
- [ ] mix test.coverage
- [ ] mix test —cover
