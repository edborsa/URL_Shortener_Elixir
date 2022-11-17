# URL Shortener

To start your Phoenix server _WITHOUT DOCKER COMPOSE_:

- Make sure that you don't have anything running on http://localhost:4000/
- Source the `.env` file with the following command: `source .env`
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To start your Phoenix server _WITH DOCKER COMPOSE_:

- Inside `config/dev.exs` change the hostname variable from `localhost`to `db`:

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

- Make sure that you don't have anything running on http://localhost:4000/.
- Make sure that port `5432` for POSTGRES is available
- Run `docker-compose up --build`

To test the API endpoint, run the following command:

```curl
curl --location --request POST 'http://localhost:4000/api/gen_short_url' \
--header 'Content-Type: application/json' \
--data-raw '{
    "url": "https://www.google.com/"
}'
```
