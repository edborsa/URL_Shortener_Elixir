defmodule URLShortenerWeb.UrlShortenerLive.IndexTest do
  use URLShortenerWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Ecto.Adapters.SQL.Sandbox
  alias URLShortener.CounterService

  describe "Index" do
    setup _context do
      pid = start_supervised!(CounterService)
      Sandbox.allow(URLShortener.Repo, self(), pid)
      :ok
    end

    test "SUCCESS: Can visit url shortner index page", %{conn: conn} do
      {:ok, index_live, html} = live(conn, Routes.url_shortener_index_path(conn, :index))

      assert html =~ "Plase Input Your URL"
      assert render(index_live) =~ "Plase Input Your URL"
    end

    test "SUCCESS: Can submit url and the short link is displayed", %{conn: conn} do
      {:ok, index_live, html} = live(conn, Routes.url_shortener_index_path(conn, :index))

      refute html =~ "Your Short Link"

      assert index_live
             |> form("#short_url_gen_form", %{"short_url_form[url]" => "https://google.com/"})
             |> render_submit()
             |> Kernel.=~("Your Short Link")
    end

    test "ERROR: Can submit empty url, but NO short link short link is displayed.", %{conn: conn} do
      {:ok, index_live, html} = live(conn, Routes.url_shortener_index_path(conn, :index))

      refute html =~ "Your Short Link"

      refute index_live
             |> form("#short_url_gen_form", %{"short_url_form[url]" => ""})
             |> render_submit()
             |> Kernel.=~("Your Short Link")
    end
end
