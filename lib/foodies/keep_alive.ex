defmodule Foodies.KeepAlive do
  def ping do
    # we ping only since 8 until 23
    if Enum.member?(8..23, current_hour_to_integer()) do
      HTTPoison.get('https://boiling-springs-51826.herokuapp.com')
    end
  end

  def current_hour_to_integer do
    {_, formatted_hour} = Timex.format(Timex.now("Europe/Prague"), "%H", :strftime)
    {integer, _} = Integer.parse(formatted_hour)
    integer
  end
end
