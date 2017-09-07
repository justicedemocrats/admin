# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :admin,
  ecto_repos: [Osdi.Repo]

# Configures the endpoint
config :admin, Admin.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bfsqn9AcIMywYeFfFrwwtpRis6Jda9AQdRrc20qyXzQlB4oBV/FA+Isy4jDAB77n",
  render_errors: [view: Admin.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Admin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :osdi, Osdi.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "osdi_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  types: GeoExample.PostgresTypes

config :cosmic, slug: "brand-new-congress"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"