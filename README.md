# DerpyCoder

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix`

Visit [`localhost:4000`](http://localhost:4000), for magic!!

* To reset DB: `mix ecto.reset`
* To start just iex: `PHX_SERVER=false iex -S mix`
* To run software quality analytics: `mix credo`
* To test: `mix test`

* To test
  * mix test --cover --export-coverage default
  * mix test.coverage
  * mix test —cover
