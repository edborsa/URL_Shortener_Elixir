defmodule URLShortener.Repo.Migrations.CreateRanges do
  use Ecto.Migration

  def change do
    create table(:ranges, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:lower_bound, :integer)
      add(:upper_bound, :integer)

      timestamps()
    end
  end
end
