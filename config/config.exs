# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :socker,
  ecto_repos: [Socker.Repo]

# Configures the endpoint
config :socker, SockerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H45b6wyxbmfyzLRZuAdU6IBh59VydoqFrhB7qVViMJOhcvuJ2V92me8CNAkM3c8R",
  render_errors: [view: SockerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Socker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
