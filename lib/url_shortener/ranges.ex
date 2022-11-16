defmodule URLShortener.Ranges do
  @moduledoc """
  The Ranges context.
  """

  @range_size 100
  import Ecto.Query, warn: false
  alias URLShortener.Repo

  alias URLShortener.Ranges.Range

  @doc """
  Returns the list of ranges.

  ## Examples

      iex> list_ranges()
      [%Range{}, ...]

  """
  def list_ranges do
    Repo.all(Range)
  end

  @doc """
  Gets a single range.

  Raises `Ecto.NoResultsError` if the Range does not exist.

  ## Examples

      iex> get_range!(123)
      %Range{}

      iex> get_range!(456)
      ** (Ecto.NoResultsError)

  """
  def get_range!(id), do: Repo.get!(Range, id)

  def get_next_range() do
    from(c in Range, order_by: [{:desc, :inserted_at}], limit: 1)
    |> Repo.one()
    |> case do
      nil ->
        %Range{}
        |> Range.changeset(%{lower_bound: 0, upper_bound: @range_size})
        |> Repo.insert()

      %Range{upper_bound: up} ->
        %Range{}
        |> Range.changeset(%{lower_bound: up + 1, upper_bound: up + @range_size})
        |> Repo.insert()
    end
  end

  @doc """
  Creates a range.

  ## Examples

      iex> create_range(%{field: value})
      {:ok, %Range{}}

      iex> create_range(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_range(attrs \\ %{}) do
    %Range{}
    |> Range.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a range.

  ## Examples

      iex> update_range(range, %{field: new_value})
      {:ok, %Range{}}

      iex> update_range(range, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_range(%Range{} = range, attrs) do
    range
    |> Range.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a range.

  ## Examples

      iex> delete_range(range)
      {:ok, %Range{}}

      iex> delete_range(range)
      {:error, %Ecto.Changeset{}}

  """
  def delete_range(%Range{} = range) do
    Repo.delete(range)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking range changes.

  ## Examples

      iex> change_range(range)
      %Ecto.Changeset{data: %Range{}}

  """
  def change_range(%Range{} = range, attrs \\ %{}) do
    Range.changeset(range, attrs)
  end
end
