defmodule URLShortener.URLStore.MappedURL do
  use Ecto.Schema
  import Ecto.Changeset
  alias URLShortener.CounterService
  alias URLShortener.Helpers.Encoder

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "mapped_urls" do
    field :long_url, :string
    field :short_url, :string
    field :visited, :integer, default: 0

    timestamps()
  end

  def changeset(short_to_long, attrs) do
    short_to_long
    |> cast(attrs, [:long_url, :short_url, :visited])
    |> validate_required([:long_url, :short_url, :visited])
  end

  def creation_changeset(mapped_url, attrs) do
    mapped_url
    |> cast(attrs, [:long_url])
    |> validate_required([:long_url])
    |> create_short_url()
  end

  defp create_short_url(%Ecto.Changeset{valid?: true} = changeset) do
    encoded_62_num =
      CounterService.get_next_num()
      |> Encoder.encode_base_62()

    Ecto.Changeset.change(changeset, %{short_url: encoded_62_num})
  end

  defp create_short_url(%Ecto.Changeset{valid?: false} = changeset), do: changeset
end
