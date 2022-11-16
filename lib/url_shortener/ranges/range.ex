defmodule URLShortener.Ranges.Range do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ranges" do
    field :lower_bound, :integer
    field :upper_bound, :integer

    timestamps()
  end

  @doc false
  def changeset(range, attrs) do
    range
    |> cast(attrs, [:lower_bound, :upper_bound])
    |> validate_required([:lower_bound, :upper_bound])
    |> validate_number(:lower_bound, greater_than_or_equal_to: 0)
    |> validate_number(:upper_bound, greater_than_or_equal_to: 0)
  end
end
