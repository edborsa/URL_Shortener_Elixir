defmodule UrlShortenerWeb.ExportControllerTest do
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

    test "SUCCESS: Can export CSV file for mapped URLS", %{conn: conn} do
      {:ok, _url} = URLStore.create_mapped_url(%{"long_url" => "https://google.com/"})
      conn = post(conn, Routes.export_path(conn, :create))
      assert response = response(conn, 200)
      assert response =~ "long_url,short_url,visited\r\n"
      assert response =~ "https://google.com/"
      assert response =~ "0"
    end
  end
end
