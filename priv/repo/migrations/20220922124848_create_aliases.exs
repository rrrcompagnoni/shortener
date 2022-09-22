defmodule Shortener.Repo.Migrations.CreateAliases do
  use Ecto.Migration

  def change do
    create table(:aliases, primary_key: false) do
      add :id, :string, null: false, primary_key: true
      add :url, :map, null: false
    end
  end
end
