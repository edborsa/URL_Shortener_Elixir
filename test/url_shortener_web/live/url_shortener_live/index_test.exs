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

    test "SUCCESS: Can visit url shortner index page 2", %{conn: conn} do
      {:ok, index_live, html} = live(conn, Routes.url_shortener_index_path(conn, :index))

      refute html =~ "Your Short Link"

      assert index_live
             |> form("#short_url_gen_form", %{"short_url_form[url]" => "https://google.com/"})
             |> render_submit()
             |> Kernel.=~("Your Short Link")
    end

    test "SUCCESS: Can visit url shortner index page 3", %{conn: conn} do
      {:ok, index_live, html} = live(conn, Routes.url_shortener_index_path(conn, :index))

      refute html =~ "Your Short Link"

      refute index_live
             |> form("#short_url_gen_form", %{"short_url_form[url]" => ""})
             |> render_submit()
             |> Kernel.=~("Your Short Link")
    end

    # test "lists all some_schemas", %{conn: conn, some_schema: some_schema} do
    #   {:ok, _index_live, html} = live(conn, Routes.some_schema_index_path(conn, :index))
    #
    #   assert html =~ "Listing Some schemas"
    #   assert html =~ some_schema.bar
    # end
    #
    # test "saves new some_schema", %{conn: conn} do
    #   {:ok, index_live, _html} = live(conn, Routes.some_schema_index_path(conn, :index))
    #
    #   assert index_live |> element("a", "New Some schema") |> render_click() =~
    #            "New Some schema"
    #
    #   assert_patch(index_live, Routes.some_schema_index_path(conn, :new))
    #
    #   assert index_live
    #          |> form("#some_schema-form", some_schema: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"
    #
    #   {:ok, _, html} =
    #     index_live
    #     |> form("#some_schema-form", some_schema: @create_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.some_schema_index_path(conn, :index))
    #
    #   assert html =~ "Some schema created successfully"
    #   assert html =~ "some bar"
    # end
    #
    # test "updates some_schema in listing", %{conn: conn, some_schema: some_schema} do
    #   {:ok, index_live, _html} = live(conn, Routes.some_schema_index_path(conn, :index))
    #
    #   assert index_live |> element("#some_schema-#{some_schema.id} a", "Edit") |> render_click() =~
    #            "Edit Some schema"
    #
    #   assert_patch(index_live, Routes.some_schema_index_path(conn, :edit, some_schema))
    #
    #   assert index_live
    #          |> form("#some_schema-form", some_schema: @invalid_attrs)
    #          |> render_change() =~ "can&#39;t be blank"
    #
    #   {:ok, _, html} =
    #     index_live
    #     |> form("#some_schema-form", some_schema: @update_attrs)
    #     |> render_submit()
    #     |> follow_redirect(conn, Routes.some_schema_index_path(conn, :index))
    #
    #   assert html =~ "Some schema updated successfully"
    #   assert html =~ "some updated bar"
    # end
    #
    # test "deletes some_schema in listing", %{conn: conn, some_schema: some_schema} do
    #   {:ok, index_live, _html} = live(conn, Routes.some_schema_index_path(conn, :index))
    #
    #   assert index_live |> element("#some_schema-#{some_schema.id} a", "Delete") |> render_click()
    #   refute has_element?(index_live, "#some_schema-#{some_schema.id}")
    # end
  end

  # describe "Show" do
  #   setup [:create_some_schema]
  #
  #   test "displays some_schema", %{conn: conn, some_schema: some_schema} do
  #     {:ok, _show_live, html} = live(conn, Routes.some_schema_show_path(conn, :show, some_schema))
  #
  #     assert html =~ "Show Some schema"
  #     assert html =~ some_schema.bar
  #   end
  #
  #   test "updates some_schema within modal", %{conn: conn, some_schema: some_schema} do
  #     {:ok, show_live, _html} = live(conn, Routes.some_schema_show_path(conn, :show, some_schema))
  #
  #     assert show_live |> element("a", "Edit") |> render_click() =~
  #              "Edit Some schema"
  #
  #     assert_patch(show_live, Routes.some_schema_show_path(conn, :edit, some_schema))
  #
  #     assert show_live
  #            |> form("#some_schema-form", some_schema: @invalid_attrs)
  #            |> render_change() =~ "can&#39;t be blank"
  #
  #     {:ok, _, html} =
  #       show_live
  #       |> form("#some_schema-form", some_schema: @update_attrs)
  #       |> render_submit()
  #       |> follow_redirect(conn, Routes.some_schema_show_path(conn, :show, some_schema))
  #
  #     assert html =~ "Some schema updated successfully"
  #     assert html =~ "some updated bar"
  #   end
  # end
end
