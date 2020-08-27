defmodule TurboCounterWeb.CountLive do
  use TurboCounterWeb, :live_view
  alias TurboCounter.Counters

  def mount(_params, _session, socket) do
    # :timer.send_interval(1000, self(), :tick)
    {
      :ok,
      socket
      |> new
      |> new_changeset
    }
  end

  defp new(socket) do
    assign(socket, counters: Counters.new())
  end

  defp new_changeset(socket) do
    assign(
      socket,
      changeset: Counters.validate_new_counter(socket.assigns.counters, %{})
    )
  end

  def render(assigns) do
    ~L"""
    <h1>Welcome to Turbo Counter</h1>
    <h2>If you dream it, we can count it.</h2>
    <hr>
    <%= for {name, count} <- @counters do %>
      <p>
        <%= name %>: <%= count %>
        <button phx-click="inc" phx-value-counter="<%= name %>">inc</button>
        | <button phx-click="dec" phx-value-counter="<%= name %>">dec</button>
        | <button phx-click="clear" phx-value-counter="<%= name %>">clear</button>
        | <button phx-click="remove" phx-value-counter="<%= name %>">remove</button>
      </p>
    <% end %>

    <%= f = form_for @changeset, "#",
      phx_change: "validate",
      phx_submit: "add" %>

      <%= label f, :name %>
      <%= text_input f, :name %>
      <%= error_tag f, :name %>

      <%= submit "Add Counter",
          phx_disable_with: "Adding...",
          disabled: !@changeset.valid?() %>
    </form>
    """
  end

  defp inc(socket, counter) do
    assign(socket, counters: Counters.inc(socket.assigns.counters, counter))
  end

  defp dec(socket, counter) do
    assign(socket, counters: Counters.dec(socket.assigns.counters, counter))
  end

  defp clear(socket, counter) do
    assign(socket, counters: Counters.clear(socket.assigns.counters, counter))
  end

  defp validate(socket, params) do
    changeset =
      socket.assigns.counters
      |> Counters.validate_new_counter(params)
      |> Map.put(:action, :validate)

    assign(socket, changeset: changeset)
  end

  defp add_counter(socket, params) do
    if socket.assigns.changeset.valid?() do
      assign(
        socket,
        counters: Counters.add_counter(socket.assigns.counters, params["name"], 0)
      )
      |> new_changeset()
    else
      socket
    end
  end

  defp remove_counter(socket, counter) do
    assign(
      socket,
      counters: Counters.remove_counter(socket.assigns.counters, counter)
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
  def handle_event("validate", %{"counter" => params}, socket) do
    {:noreply, validate(socket, params)}
  end
  def handle_event("add", %{"counter" => params}, socket) do
    {:noreply, socket |> validate(params) |> add_counter(params) }
  end
  def handle_event("remove", %{"counter" => counter}, socket) do
    {:noreply, remove_counter(socket, counter)}
  end
end
