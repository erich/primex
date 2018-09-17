defmodule Foodies.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link(port) do
    {port_as_integer, _} = Integer.parse(port)
    Plug.Adapters.Cowboy2.http(Foodies.Router, [], port: port_as_integer)
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
