defmodule UrlShortenerWeb.UrlShortenerLive.StatsTest do
  use URLShortenerWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "Index" do
    test "SUCCESS: Can visit url shortner index page", %{conn: conn} do
      {:ok, index_live, html} = live(conn, Routes.url_shortener_stats_path(conn, :stats))

      assert html =~ "Long URL"
      assert render(index_live) =~ "Long URL"
    end
  end
end
