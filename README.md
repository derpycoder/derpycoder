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

## Imgproxy Code
- Imgproxy.new("https://placekitten.com/200/300") |> to_string()
- Imgproxy.new("s3://honeycomb/phoenix.png") \
  |> Imgproxy.resize(512, 64) \
  |> Imgproxy.set_extension("png") \
  |> to_string()

## Finch & Req
- req = Req.new(base_url: "https://httpbin.org")
- Req.get!(req, url: "/status/200").status
- Req.get!("https://derpycoder.site", finch: DerpyCoder.Finch).body
- Finch.build(:get, "http://localhost:4000") |> Finch.request(DerpyCoder.Finch)
- Finch.build(:get, "https://s3.derpycoder.site") |> Finch.request(DerpyCoder.Finch)
- Finch.build(:get, "https://self-signed.badssl.com") |> Finch.request(DerpyCoder.Finch)

## ExAws
- ExAws.S3.list_buckets() |> ExAws.request!()

- local_image = File.read!("priv/static/images/phoenix.png")
- ExAws.S3.put_bucket("bee", "") |> ExAws.request!()

- ExAws.S3.put_object("bee", "priv/static/phoenix.png", local_image) |> ExAws.request!()
- # images -> img, videos -> vdo, pdfs -> pdf, etc - i.e. img.derpycoder.site
- opts = [virtual_host: true, bucket_as_host: true]
- ExAws.Config.new(:s3) |> S3.presigned_url(:get, "bee.derpycoder.site", "priv/static/phoenix.png", opts)

- # my-eu-bucket-3, my-project-x, 4my-group
- ExAws.Config.new(:s3) |> ExAws.S3.presigned_url(:get, "honeycomb", "phoenix.png")
- ExAws.Config.new(:s3) |> ExAws.S3.presigned_url(:get, "bee", "priv/static/phoenix.png")
- ExAws.Config.new(:s3) |> ExAws.S3.presigned_url(:get, "bee", "priv/static/phoenix.png", [expires_in: 300])

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
