defmodule Foodies.Persistence do
  use Timex
  alias Foodies.{KeyValue, HtmlParser}

  def update do
    # we update only on mon - fri
    if Enum.member?(1..5, weekday_number()) do
      unless weekday_number() == last_day_update() do
        KeyValue.put(:forkys, HtmlParser.get_html())
      end
    end
  end

  def last_day_update do
    KeyValue.get(:forkys)[:weekday_number]
  end

  # Duplication in HtmlParser
  def weekday_number do
    Timex.today()
    |> Timex.weekday()
  end
end
