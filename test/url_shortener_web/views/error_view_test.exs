defmodule URLShortenerWeb.ErrorViewTest do
  use URLShortenerWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(URLShortenerWeb.ErrorView, "404.html", []) =~ "Invalid Short Link"
  end

  test "renders 500.html" do
    assert render_to_string(URLShortenerWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
