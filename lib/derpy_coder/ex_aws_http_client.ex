defmodule DerpyCoder.ExAwsHttpClient do
  @moduledoc """
  Taken from: https://gist.github.com/myobie/1858944b1be86e43f5d37c007e878d48
  """
  @behaviour ExAws.Request.HttpClient

  require Logger

  def request(method, url, body, headers, http_opts) do
    case http_opts do
      [] -> :noop
      opts -> Logger.debug(inspect({:http_opts, opts}))
    end

    with {:ok, resp} <-
           Finch.build(method, url, headers, body)
           |> Finch.request(DerpyCoder.Finch) do
      {:ok, %{status_code: resp.status, body: resp.body, headers: resp.headers}}
    else
      {:error, reason} ->
        {:error, %{reason: reason}}
    end
  end
end
