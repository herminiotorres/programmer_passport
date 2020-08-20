defmodule TurboCounterWeb.CountLive do
  use TurboCounterWeb, :live_view
  alias TurboCounter.Counter

  def mount(_params, _session, socket) do
    # :timer.send_interval(1000, self(), :tick)
    {
      :ok,
      socket
      |> new
    }
  end

  defp new(socket) do
    assign(socket, counters: Counter.new())
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to Turbo Counter</h1>
    <h2>If you dream it, we can count it.</h2>
    <hr>
    <%= for {name, count} <- @counters do %>
      <p>
        Counter <%= name %>: <%= count %>
        <button phx-click="inc" phx-value-counter="<%= name %>">inc</button>
        | <button phx-click="dec" phx-value-counter="<%= name %>">dec</button>
        | <button phx-click="clear" phx-value-counter="<%= name %>">clear</button>
        | <button phx-click="remove" phx-value-counter="<%= name %>">remove</button>
      </p>
    <% end %>
    <button phx-click="add">add counter</button>
    """
  end

  defp inc(socket, counter) do
    assign(socket, counters: Counter.inc(socket.assigns.counters, counter))
  end

  defp dec(socket, counter) do
    assign(socket, counters: Counter.dec(socket.assigns.counters, counter))
  end

  defp clear(socket, counter) do
    assign(socket, counters: Counter.clear(socket.assigns.counters, counter))
  end

  defp add_counter(socket) do
    assign(
      socket,
      counters: Counter.add_counter(socket.assigns.counters)
    )
  end

  defp remove_counter(socket, counter) do
    assign(
      socket,
      counters: Counter.remove_counter(socket.assigns.counters, counter)
    )
  end

  def handle_event("inc", %{"counter" => counter}, socket) do
    {:noreply, inc(socket, counter)}
  end
  def handle_event("dec", %{"counter" => counter}, socket) do
    {:noreply, dec(socket, counter)}
  end
  def handle_event("clear", %{"counter" => counter}, socket) do
    {:noreply, clear(socket, counter)}
  end
  def handle_event("add", _params, socket) do
    {:noreply, add_counter(socket)}
  end
  def handle_event("remove", %{"counter" => counter}, socket) do
    {:noreply, remove_counter(socket, counter)}
  end
end
