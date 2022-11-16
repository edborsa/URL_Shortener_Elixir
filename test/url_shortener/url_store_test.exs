defmodule URLShortener.URLStoreTest do
  use URLShortener.DataCase
  import URLShortener.Factory

  alias Ecto.Adapters.SQL.Sandbox
  alias URLShortener.CounterService
  alias URLShortener.URLStore

  describe "mapped_urls" do
    setup _context do
      pid = start_supervised!(CounterService)
      Sandbox.allow(URLShortener.Repo, self(), pid)
      :ok
    end

    alias URLShortener.URLStore.MappedURL

    test "list_mapped_urls/0 returns all mapped_urls" do
      mapped_url = insert(:mapped_url)
      assert URLStore.list_mapped_urls() == [mapped_url]
    end

    test "SUCCESS: get_long_url_by_short/1 returns the long_url" do
      mapped_url = insert(:mapped_url)
      assert URLStore.get_long_url_by_short_url(mapped_url.short_url) == {:ok, mapped_url}
    end

    test "FAILURE: get_long_url_by_short/1 returns the long_url" do
      assert URLStore.get_long_url_by_short_url("NON EXISTING") == {:error, "record not found"}
    end

    test "get_mapped_url!/1 returns the mapped_url with given id" do
      mapped_url = insert(:mapped_url)
      assert URLStore.list_mapped_urls() == [mapped_url]
      assert URLStore.get_mapped_url!(mapped_url.id) == mapped_url
    end

    test "create_mapped_url/1 with valid data creates a mapped_url" do
      valid_attrs = params_for(:mapped_url)

      assert {:ok, %MappedURL{} = mapped_url} = URLStore.create_mapped_url(valid_attrs)
      assert mapped_url.long_url == valid_attrs.long_url
      assert mapped_url.visited == 0
    end

    test "create_mapped_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = URLStore.create_mapped_url(%{})
    end

    test "update_mapped_url/2 with valid data updates the mapped_url" do
      mapped_url = insert(:mapped_url)

      update_attrs = %{
        long_url: "some updated long_url",
        short_url: "some updated short_url",
        visited: 43
      }

      assert {:ok, %MappedURL{} = mapped_url} =
               URLStore.update_mapped_url(mapped_url, update_attrs)

      assert mapped_url.long_url == "some updated long_url"
      assert mapped_url.short_url == "some updated short_url"
      assert mapped_url.visited == 43
    end

    test "update_mapped_url/2 with invalid data returns error changeset" do
      mapped_url = insert(:mapped_url)

      assert {:error, %Ecto.Changeset{}} =
               URLStore.update_mapped_url(mapped_url, %{long_url: nil})

      assert mapped_url == URLStore.get_mapped_url!(mapped_url.id)
    end

    test "delete_mapped_url/1 deletes the mapped_url" do
      mapped_url = insert(:mapped_url)
      assert {:ok, %MappedURL{}} = URLStore.delete_mapped_url(mapped_url)
      assert_raise Ecto.NoResultsError, fn -> URLStore.get_mapped_url!(mapped_url.id) end
    end

    test "change_mapped_url/1 returns a mapped_url changeset" do
      mapped_url = insert(:mapped_url)
      assert %Ecto.Changeset{} = URLStore.change_mapped_url(mapped_url)
    end
  end
end
