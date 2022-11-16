defmodule URLShortenerWeb.URLShortenerLive.Stats do
  use URLShortenerWeb, :live_view
  alias URLShortener.URLStore

  @impl true
  def mount(_assigns, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_unsigned_params, _uri, socket) do
    all_mapped_urls = URLStore.list_mapped_urls()

    {:noreply,
     socket
     |> assign(:all_mapped_urls, all_mapped_urls)}
  end
end
