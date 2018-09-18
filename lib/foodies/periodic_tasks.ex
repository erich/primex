defmodule Foodies.PeriodicTasks do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    # In 10 minutes
    Process.send_after(self(), :work, 10 * 60 * 1000)
    {:ok, state}
  end

  def handle_info(:work, state) do
    Foodies.Persistence.update()
    Foodies.KeepAlive.ping()
    # Start the timer again
    # In 10 minutes
    Process.send_after(self(), :work, 10 * 60 * 1000)

    {:noreply, state}
  end
end
