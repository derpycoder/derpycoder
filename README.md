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

## MinIO
- brew install minio
- minio server start (http://localhost:9000) [minioadmin, minioadmin]
- asdf plugin add minio https://github.com/aeons/asdf-minio.git
- minio 2022-09-01T23-53-36Z (In ASDF file)

- brew install minio-mc
- asdf plugin-add mc https://github.com/penpyt/asdf-mc.git

- mc alias set minio http://192.168.43.106:9000 minioadmin minioadmin
- mc mb minio/honeycomb
- mc cp priv/static/images/phoenix.png minio/honeycomb

## Figure out Imgproxy
- IMGPROXY_USE_S3=true\
  AWS_ACCESS_KEY_ID=minioadmin\
  AWS_SECRET_ACCESS_KEY=minioadmin\
  IMGPROXY_S3_ENDPOINT=http://192.168.43.106:9000\
  imgproxy
- http://localhost:8080/insecure/rs:fit:512:64:no:0/plain/s3://honeycomb/phoenix.png@png

## PGWeb
- brew install pgweb
- pgweb --host localhost --user root --db derpy_coder_dev --port 26257

## Monitoring
- brew install prometheus
- brew install grafana
- brew install loki

## Proxy & Cache
- brew install varnish
- brew install haproxy
