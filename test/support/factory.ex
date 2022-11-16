defmodule URLShortener.Factory do
  use ExMachina.Ecto, repo: URLShortener.Repo

  alias URLShortener.Ranges.Range
  alias URLShortener.URLStore.MappedURL

  def range_factory(attrs) do
    default = %{
      lower_bound: sequence(:lower_bound, & &1),
      upper_bound: sequence(:lower_bound, &(&1 + 5))
    }

    attrs = merge_attributes(default, attrs)

    %Range{}
    |> Range.changeset(attrs)
    |> Ecto.Changeset.apply_changes()
  end

  def mapped_url_factory(attrs) do
    default = %{
      long_url: "https://www.google.com/"
    }

    attrs = merge_attributes(default, attrs)

    %MappedURL{}
    |> MappedURL.creation_changeset(attrs)
    |> Ecto.Changeset.apply_changes()
  end
end
