defmodule Foodies.PeriodicTasks do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work, 10 * 60 * 1000) # In 10 minutes
    {:ok, state}
  end

  def handle_info(:work, state) do
    Foodies.Persistence.update()
    Foodies.KeepAlive.ping()
    # Start the timer again
    Process.send_after(self(), :work, 10 * 60 * 1000) # In 10 minutes

    {:noreply, state}
  end
end
