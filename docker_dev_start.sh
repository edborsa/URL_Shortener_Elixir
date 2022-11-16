cat .env
source .env
mix do deps.get, deps.compile
mix ecto.drop
mix ecto.create
mix ecto.migrate
exec mix phx.server
