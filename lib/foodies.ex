defmodule Foodies do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Foodies.PeriodicTasks, []),
      worker(Foodies.KeyValue, []),
      worker(Foodies.Router, [System.get_env("PORT")]),
      worker(Foodies.SlackRtm, [System.get_env("SLACK_TOKEN")])
    ]

    opts = [strategy: :one_for_one, name: Foodies.Supervisor]

    Supervisor.start_link(children, opts)
  end
end
