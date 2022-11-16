defmodule URLShortenerWeb.URLShortenerLive.Index do
  use URLShortenerWeb, :live_view

  alias URLShortener.URLStore
  alias URLShortener.URLStore.MappedURL

  @impl true
  def mount(_assigns, _session, socket) do
    {:ok, socket |> assign(:short_url, "")}
  end

  @impl true
  def handle_params(_unsigned_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "generate_short_url",
        %{"short_url_form" => %{"url" => ""}},
        socket
      ) do
    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "generate_short_url",
        %{"short_url_form" => %{"url" => url}},
        socket
      ) do
    {:ok, url = %MappedURL{}} = URLStore.create_mapped_url(%{long_url: url})

    {:noreply,
     socket
     |> assign(:short_url, url.short_url)
     |> put_flash(:info, "Your Short URL was generated")
     |> push_patch(to: Routes.url_shortener_index_path(socket, :index))}
  end
end
