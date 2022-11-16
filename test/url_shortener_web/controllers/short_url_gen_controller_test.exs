defmodule UrlShortenerWeb.ShortUrlGenControllerTest do
  use URLShortenerWeb.ConnCase, async: false
  alias Ecto.Adapters.SQL.Sandbox

  describe "redirect" do
    setup _context do
      pid = start_supervised!(URLShortener.CounterService)
      Sandbox.allow(URLShortener.Repo, self(), pid)
      :ok
    end

    test "SUCCESS: Redirect to long url", %{conn: conn} do
      conn =
        post(conn, Routes.short_url_gen_path(conn, :create, %{"url" => "https://google.com/"}))

      assert response = json_response(conn, 200)
      assert %{"short_url" => url} = response
      assert url =~ System.get_env("HOST_NAME")
    end

    test "ERROR: Redirect to long url", %{conn: conn} do
      conn = post(conn, Routes.short_url_gen_path(conn, :create, %{"url" => "foo"}))

      assert response = json_response(conn, 422)
      assert response == %{"error" => "invalid url: foo"}
    end
  end
end
