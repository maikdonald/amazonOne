# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config


config :amazonOne,
  ecto_repos: [AmazonOne.Repo]

# Configures the endpoint
config :amazonOne, AmazonOneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rjRot9m2oozUWRcfguOcZhnv2fc8DS04MX+GZ6n+0Fv/YqeNKq5EcfpUDDze/aY/",
  render_errors: [view: AmazonOneWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AmazonOne.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :amazonOne, BasicAuth, username: "admin", password: "secret"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
