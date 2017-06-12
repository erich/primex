defmodule Foodies.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link do
    Plug.Adapters.Cowboy.http(Foodies.Router, [])
  end

  get "/" do
    conn
    |> send_resp(200, "Primex")
  end
end
