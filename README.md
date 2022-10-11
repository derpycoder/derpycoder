# DerpyCoder

## Setup
### For Environment Setup:
* Install brew
* Install asdf

### For Tools & Dependencies
* brew install go-task/tap/go-task
* task install:asdf
* task install:tools
* task install:deps

* task spawn:cockroaches
* task disperse:cockroaches (http://localhost:9080)

* task setup:ecto

* task start:server (http://localhost:4000)

> Install DBeaver for inspecting the database.

## For more commands:
* mix help
* task -l

## Global Paths & Env vars:
> Must have installed `code` command in path, for file to open in VS Code!!

* task open:zsh

### Add following to zshrc:
* source $(brew --prefix asdf)/libexec/asdf.sh

### Add following to zshenv:
* export ELIXIR_EDITOR="code --goto __FILE__:__LINE__"

## Icon:
- [HeroIcons](https://heroicons.com)
- [SVG Repo](https://www.svgrepo.com)
- [SVG OMG](https://jakearchibald.github.io/svgomg/) - Never Automatically Compress SVG Images!!

## To Add:
- [ ] Clickhouse Installation

## Fix:
- [ ] mix test --cover --export-coverage default
- [ ] mix test.coverage
- [ ] mix test --color

# TODO:
- [ ] Robots.txt
- [ ] Warrant Canary
- [ ] Ads.txt

## Monitoring
- brew install prometheus
- brew install grafana
- brew install loki

- brew install pnpm
- brew install --cask google-chrome
- npm install -g lighthouse
- npm install -g serve
- lighthouse https://derpycoder.site \
  --chrome-flags="--headless" \
  --output-path="performance/lighthouse.html" \
  --form-factor="desktop" \
  --screenEmulation.disabled \
  --view
- serve performance
- http://localhost:3000/lighthouse

- npm install -g sitespeed.io
- sitespeed.io https://derpycoder.site -b chrome -n 1 -o --headless

- rqlite for config storage & feature flags.

- Start order
  - Cockroach | MinIO
  - Haproxy | Phoenix Server
