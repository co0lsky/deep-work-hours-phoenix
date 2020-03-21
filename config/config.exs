# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :deep_work_hours, DeepWorkHours.Repo,
  database: "deep_work_hours_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :deep_work_hours,
  ecto_repos: [DeepWorkHours.Repo]

# Configures the endpoint
config :deep_work_hours, DeepWorkHoursWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dwd3GuPH4bqgsdw97nDxtUco2iHn5sU0tAOxxD/+ijd9eRcVdEoRqJSWPOsqjopc",
  render_errors: [view: DeepWorkHoursWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DeepWorkHours.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "z5p5SgXp"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use Tzdata for timezone
config :elixir, :time_zone_database, Tzdata.TimeZoneDatabase

# Configures Ueberauth
config :ueberauth, Ueberauth,
  providers: [
    auth0: {Ueberauth.Strategy.Auth0, []}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
