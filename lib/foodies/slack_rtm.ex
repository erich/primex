defmodule Foodies.SlackRtm do
  use Slack
  alias Foodies.{SlackRtm, KeyValue}

  def start_link(token) do
    Slack.Bot.start_link(SlackRtm, [], token)
  end

  def handle_connect(slack, state) do
    {:ok, state}
  end

  def handle_event(message = %{type: "message"}, slack, state) do
    forkys_menu = KeyValue.get(:forkys)
    send_message(":tea: #{forkys_menu[:soup]} :fork_and_knife: #{forkys_menu[:main_course]}", message.channel, slack)

    {:ok, state}
  end
  def handle_event(_, _, state), do: {:ok, state}

  def handle_info({:message, text, channel}, slack, state) do
    send_message(text, channel, slack)

    {:ok, state}
  end
  def handle_info(_, _, state), do: {:ok, state}
end
