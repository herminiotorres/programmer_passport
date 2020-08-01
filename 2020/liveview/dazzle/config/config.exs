# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dazzle,
  ecto_repos: [Dazzle.Repo]

# Configures the endpoint
config :dazzle, DazzleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ckNZ2rnq6yV5bs3wcX3pb4IW3VTZk8LPKEHa/qeiT5hSduakkW3B/txpgeyk6imc",
  render_errors: [view: DazzleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dazzle.PubSub,
  live_view: [signing_salt: "rm8Xz3a3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
