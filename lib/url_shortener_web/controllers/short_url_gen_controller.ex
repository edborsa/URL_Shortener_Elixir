defmodule URLShortenerWeb.ShortURLGenController do
  use URLShortenerWeb, :controller

  alias URLShortener.URLStore
  alias URLShortener.URLStore.MappedURL

  action_fallback URLShortenerWeb.FallbackController

  def create(conn, %{"url" => long_url}) do
    with {:ok, long_url} <- validate_uri(long_url),
         {:ok, url = %MappedURL{}} <- URLStore.create_mapped_url(%{long_url: long_url}) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(
        200,
        Jason.encode!(%{"short_url" => System.get_env("HOST_NAME") <> url.short_url})
      )
    end
  end

  def validate_uri(str) do
    uri = URI.parse(str)

    case uri do
      %URI{scheme: nil} -> {:error, "invalid url: " <> str}
      %URI{host: nil} -> {:error, "invalid url: " <> str}
      %URI{path: nil} -> {:error, "invalid url: " <> str}
      uri -> {:ok, str}
    end
  end
end
