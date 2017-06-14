defmodule Foodies.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link(port) do
    Plug.Adapters.Cowboy.http(Foodies.Router, [], port)
  end

  get "/" do
    conn
    |> send_resp(200, "Primex")
  end

  match _ do
    conn
    |> send_resp(404, "Nothing here")
    |> halt
  end
end
