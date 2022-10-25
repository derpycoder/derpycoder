<!-- README START -->

![Phoenix Framework](images/phoenix.png)

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
  --output-path="lighthouse-result/lighthouse.html" \
  --form-factor="mobile" \
  --screenEmulation.disabled \
  --only-categories="performance,accessibility,best-practices,performance,seo" \
  --view
- serve lighthouse-result
- http://localhost:3000/lighthouse

- npm install -g sitespeed.io
- sitespeed.io https://derpycoder.site -b chrome -n 1 -o --headless
- serve sitespeed-result

- rqlite for config storage & feature flags.

## Start Order
  - Cockroach | MinIO
  - Haproxy | Phoenix Server

## Prod Build
- mix assets.deploy
- MIX_ENV=prod mix release
- mix phx.digest.clean --all
- _build/prod/rel/derpy_coder/bin/derpy_coder start

## Some Libs:
- https://www.youtube.com/watch?v=GTP0llRvEmE&t=10s
- https://github.com/zorbash/opus
- https://github.com/implicitly-awesome/exop
- https://github.com/ympons/expreso

## Update Glboal Tool Versions
- cp .tool-versions $HOME/.tool-versions

## Learning
- https://devhints.io/elixir
- https://learnxinyminutes.com/docs/elixir/
- https://elixirforum.com/t/why-are-there-so-few-elixir-courses-compared-to-js/51127/2?u=derpycoder
- [Obsidian](https://obsidian.md)

20% off ANY Pragmatic Studio 30 course!
Simply use our Devtalk coupon code devtalk.com

35% off any ebook published by PragProg 46!
Simply use our Devtalk coupon code devtalk.com

35% off any ebook, print book or video published by Manning 22!
Simply use our Devtalk coupon code devtalk.com

https://github.com/schollz/croc

## CRDT
https://github.com/topics/collaborative-editing?l=javascript&o=desc&s=
https://github.com/yjs/yjs
https://github.com/y-crdt/y-crdt
https://demos.yjs.dev/monaco/monaco.html
https://github.com/yjs/yjs-demos
https://docs.yjs.dev/ecosystem/connection-provider/y-websocket
http://automerge.org/
https://github.com/yjs/y-monaco/
https://microsoft.github.io/monaco-editor/
https://github.com/dmonad/crdt-benchmarks

https://github.com/derekkraan/delta_crdt_ex

## Checkout
https://github.com/mirego/elixir-boilerplate
https://github.com/mirego/mix_audit
https://github.com/mirego/credo_naming
https://github.com/mirego/telemetry_ui


## Peer to Peer Encryption
https://livesecret.fly.dev
https://github.com/JesseStimpson/livesecret

## Distributed deployment
You should use Horde when you want a global supervisor (or global registry, or some combination of the two) that supports automatic fail-over, dynamic cluster membership, and graceful node shutdown.


https://moosecode.nl/blog/introducing_horde
https://github.com/bitwalker/swarm
https://github.com/derekkraan/horde

<!-- README END -->
