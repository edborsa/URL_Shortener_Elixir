defmodule URLShortener.Repo.Migrations.CreateMappedUrls do
  use Ecto.Migration

  def change do
    create table(:mapped_urls, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :short_url, :string
      add :long_url, :string
      add :visited, :integer

      timestamps()
    end
  end
end
