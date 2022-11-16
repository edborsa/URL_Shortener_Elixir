defmodule URLShortenerWeb.RedirectController do
  use URLShortenerWeb, :controller

  alias URLShortener.URLStore

  action_fallback URLShortenerWeb.FallbackController

  def redirect(conn, %{"short_url" => short_url}) do
    with {:ok, url} <- URLStore.get_long_url_by_short_url(short_url),
         {:ok, url} <- URLStore.inc_visited_short_url(url) do
      Phoenix.Controller.redirect(conn, external: url.long_url)
    end
  end
end
