defmodule UrlShortenerWeb.RedirectControllerTest do
  use URLShortenerWeb.ConnCase, async: false
  alias Ecto.Adapters.SQL.Sandbox
  alias URLShortener.CounterService
  alias URLShortener.URLStore

  describe "redirect" do
    setup _context do
      pid = start_supervised!(CounterService)
      Sandbox.allow(URLShortener.Repo, self(), pid)
      :ok
    end

    test "SUCCESS: Redirect to long url", %{conn: conn} do
      {:ok, url} = URLStore.create_mapped_url(%{"long_url" => "https://google.com/"})

      conn = get(conn, Routes.redirect_path(conn, :redirect, url.short_url))
      assert redirected_to(conn, 302) =~ "https://google.com/"
    end
  end
end
