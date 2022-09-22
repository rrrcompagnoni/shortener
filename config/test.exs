import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :shortener, Shortener.Repo,
  username: "postgres",
  password: "not_a_prod_password",
  hostname: "postgres",
  database: "shortener_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shortener, ShortenerWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4002],
  secret_key_base: "Q46z7pO7adLsM/IHbKQnpLzExQTXuhSuaNgWk4HQyf4Ps8y3yCD/2rOHe9OJ2yMl",
  server: false

# In test we don't send emails.
config :shortener, Shortener.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
