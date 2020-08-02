defmodule SuperDuper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias SuperDuper.Server

  def start(_type, _args) do
    IO.puts(">>>> starting the super-duper super-visor <<<<")
    children = [
      # Starts a worker by calling: SuperDuper.Worker.start_link(arg)
      # {SuperDuper.Worker, arg}

      # %{id: :superdave, start: {Server, :start_link, [:superdave]}},
      # %{id: :superman, start: {Server, :start_link, [:superman]}},
      # %{id: :supermario, start: {Server, :start_link, [:supermario]}}
      {Server, :superdave},
      {Server, :superman},
      {Server, :supermario}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_all, name: SuperDuper.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
