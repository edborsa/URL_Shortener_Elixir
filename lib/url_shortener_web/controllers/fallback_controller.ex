defmodule URLShortenerWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use URLShortenerWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(URLShortenerWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(URLShortenerWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, message}) when is_binary(message) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(
      422,
      Jason.encode!(%{"error" => message})
    )
  end
end
