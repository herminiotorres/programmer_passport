defmodule Secret.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Secret.Worker.start_link(arg)
      # {Secret.Worker, arg}
      {Registry, [keys: :unique, name: Secret.Registry]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Secret.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
