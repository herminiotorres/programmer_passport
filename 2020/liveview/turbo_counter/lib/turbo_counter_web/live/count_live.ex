defmodule TurboCounterWeb.CountLive do
  use TurboCounterWeb, :live_view

  def mount(_params, _session, socket) do
    :timer.send_interval(1000, self(), :tick)
    {:ok, assign(socket, hello: :world, count: 0)}
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to Turbo Counter, <%= @hello %></h1>
    <h2>If you dream it, we can count it.</h2>
    <p>Count: <%= @count %></p>
    """
  end

  def count(socket) do
    assign(socket, count: socket.assigns.count + 1)
  end

  def handle_info(:tick, socket) do
    {:noreply, count(socket)}
  end
end
