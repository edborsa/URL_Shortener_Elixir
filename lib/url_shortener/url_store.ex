defmodule URLShortener.URLStore do
  @moduledoc """
  The URLStore context.
  """

  import Ecto.Query, warn: false
  alias URLShortener.Repo

  alias URLShortener.URLStore.MappedURL

  @doc """
  Returns the list of mapped_urls.

  ## Examples

      iex> list_mapped_urls()
      [%MappedURL{}, ...]

  """
  def list_mapped_urls do
    Repo.all(MappedURL)
  end

  @doc """
  Gets a single mapped_url.

  Raises `Ecto.NoResultsError` if the Mapped url does not exist.

  ## Examples

      iex> get_mapped_url!(123)
      %MappedURL{}

      iex> get_mapped_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mapped_url!(id), do: Repo.get!(MappedURL, id)

  def get_long_url_by_short_url(short_url) do
    Repo.get_by(MappedURL, short_url: short_url)
    |> case do
      nil ->
        {:error, "record not found"}

      url ->
        {:ok, url}
    end
  end

  @doc """
  Creates a mapped_url.

  ## Examples

      iex> create_mapped_url(%{field: value})
      {:ok, %MappedURL{}}

      iex> create_mapped_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mapped_url(attrs \\ %{}) do
    %MappedURL{}
    |> MappedURL.creation_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mapped_url.

  ## Examples

      iex> update_mapped_url(mapped_url, %{field: new_value})
      {:ok, %MappedURL{}}

      iex> update_mapped_url(mapped_url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mapped_url(%MappedURL{} = mapped_url, attrs) do
    mapped_url
    |> MappedURL.changeset(attrs)
    |> Repo.update()
  end

  def inc_visited_short_url(%MappedURL{} = short_to_long) do
    short_to_long
    |> MappedURL.changeset(%{visited: short_to_long.visited + 1})
    |> Repo.update()
  end

  @doc """
  Deletes a mapped_url.

  ## Examples

      iex> delete_mapped_url(mapped_url)
      {:ok, %MappedURL{}}

      iex> delete_mapped_url(mapped_url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mapped_url(%MappedURL{} = mapped_url) do
    Repo.delete(mapped_url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mapped_url changes.

  ## Examples

      iex> change_mapped_url(mapped_url)
      %Ecto.Changeset{data: %MappedURL{}}

  """
  def change_mapped_url(%MappedURL{} = mapped_url, attrs \\ %{}) do
    MappedURL.changeset(mapped_url, attrs)
  end
end
