defmodule ForkysParser do
  def get_html do
    url = 'http://www.forkys.eu/poledni-menu/poledni-menu-brno/'

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        valid_weekday_number = weekday_number()
        parse_html_to_menu(body, valid_weekday_number)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts("Not found :(")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def parse_html_to_menu(body, valid_weekday_number) do
    Floki.find(body, "#day-tab#{valid_weekday_number} h2 span")
    |> Enum.take(2)
    |> add_soup_and_main_course()
  end

  def weekday_number() do
    Timex.today()
    |> Timex.weekday()
  end

  def add_soup_and_main_course(first_two_spans) do
    %{
      soup: List.first(first_two_spans) |> Floki.text(),
      main_course: List.last(first_two_spans) |> Floki.text()
    }
  end
end
