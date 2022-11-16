# URL Shortener

To start your Phoenix server **WITHOUT DOCKER COMPOSE**:

- Be sure that you don't have anything running on http://localhost:4000/
- Source the .env file
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To start your Phoenix server **WITH DOCKER COMPOSE**:

- Inside dev.exs change the hostname to db:

```elixir
config :url_shortener, URLShortener.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "db",   # <-------- UNCOMMENT THIS ONE
  #hostname: "localhost", # <-- COMMENT THIS ONE
  database: "url_shortener_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

- Be sure that you don't have anything running on http://localhost:4000/.
- Be sure that you that default port for POSTGRES is available, A.K.A port 5432.
- run: `docker-compose up --build`.

To test the api endpont, perform a request:

```curl
curl --location --request POST 'http://localhost:4000/api/gen_short_url' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://www.google.com/"
}'
```
