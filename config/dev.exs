use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :admin, Admin.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/.bin/webpack-dev-server",
      "--inline",
      "--colors",
      "--hot",
      "--stdin",
      "--host",
      "localhost",
      "--port",
      "8080",
      "--public",
      "localhost:8080",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

config :ueberauth, Ueberauth,
  providers: [
    google: {
      Ueberauth.Strategy.Google,
      [
        approval_prompt: "force",
        access_type: "offline",
        default_scope: "email profile"
      ]
    }
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

config :admin, script_tag_base: ~s(http://localhost:8080/js/)

config :admin,
  css_tag:
    ~s(<link rel="stylesheet" type="text/css" href="http://localhost:8080/css/app.css" media="screen,projection" />)

# Cipher
config :cipher,
  keyphrase: "testiekeyphraseforcipher",
  ivphrase: "testieivphraseforcipher",
  magic_token: "magictoken"

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# command from your terminal:
#
#     openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem
#
# The `http:` config above can be replaced with:
#
#     https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :admin, Admin.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/admin_web/views/.*(ex)$},
      ~r{lib/admin_web/templates/.*(eex)$},
      ~r{lib/admin_web/channels/.*(ex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

config :rollbax, enabled: false

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Cipher
config :cipher,
  keyphrase: System.get_env("CIPHER_KEYPHRASE"),
  ivphrase: System.get_env("CIPHER_IVPHRASE")

# Proxy layer + mongo
config :admin,
  osdi_base_url: System.get_env("OSDI_BASE_URL"),
  osdi_api_token: System.get_env("OSDI_API_TOKEN"),
  mongodb_dbname: System.get_env("MONGO_DBNAME"),
  mongodb_username: System.get_env("MONGO_USERNAME"),
  mongodb_hostname: System.get_env("MONGO_HOSTNAME"),
  mongodb_password: System.get_env("MONGO_PASSWORD"),
  mongodb_port: System.get_env("MONGO_PORT"),
  deployed_url: System.get_env("DEPLOYED_URL")

config :rollbax,
  access_token: System.get_env("ROLLBAR_TOKEN"),
  environment: "production"

config :cosmic, slug: System.get_env("COSMIC_BUCKET_SLUG")

config :admin,
  cosmic_config_slug: System.get_env("COSMIC_CONFIG_SLUG"),
  whitelist_domain: System.get_env("WHITELISTED_DOMAIN"),
  help_email: System.get_env("HELP_EMAIL")
