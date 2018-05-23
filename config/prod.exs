use Mix.Config

# For production, we often load configuration from external
# sources, such as your system environment. For this reason,
# you won't find the :http configuration below, but set inside
# Admin.Endpoint.init/2 when load_from_system_env is
# true. Any dynamic configuration should be done there.
#
# Don't forget to configure the url host to something meaningful,
# Phoenix uses this information when generating URLs.
#
# Finally, we also include the path to a cache manifest
# containing the digested version of static files. This
# manifest is generated by the mix phx.digest task
# which you typically run after static files are built.
config :admin, Admin.Endpoint,
  load_from_system_env: true,
  check_origin: [
    "https://admin.justicedemocrats.com",
    "https://turnout.justicedemocrats.com",
    "https://esm.betofortexas.com",
    "https://beto-esm.gigalixirapp.com"
  ],
  url: [host: "turnout.justicedemocrats.com", port: 4000],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true

# Do not print debug messages in production
config :logger, level: :info

config :admin, script_tag: ~s(/js/)

config :admin,
  css_tag:
    ~s(<link rel="stylesheet" type="text/css" href="/css/app.css" media="screen,projection" />)

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
  client_id: "${GOOGLE_CLIENT_ID}",
  client_secret: "${GOOGLE_CLIENT_SECRET}"

# Cipher
config :cipher,
  keyphrase: "${CIPHER_KEYPHRASE}",
  ivphrase: "${CIPHER_IVPHRASE}"

# Proxy layer + mongo
config :admin,
  osdi_base_url: "${OSDI_BASE_URL}",
  osdi_api_token: "${OSDI_API_TOKEN}",
  mongodb_username: "${MONGO_USERNAME}",
  mongodb_hostname: "${MONGO_HOSTNAME}",
  mongodb_password: "${MONGO_PASSWORD}",
  mongodb_port: "${MONGO_PORT}",
  deployed_url: "${DEPLOYED_URL}"

config :rollbax,
  access_token: "${ROLLBAR_TOKEN}",
  environment: "production"

config :cosmic, slug: "${COSMIC_BUCKET_SLUG}"

config :admin,
  cosmic_info_slug: "${COSMIC_CONFIG_SLUG}",
  whitelist_domain: "${WHITELISTED_DOMAIN}"
