defmodule Kefis.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :integer
      add :sku, :string
      add :category, :string
      add :image, :string

      timestamps()
    end
  end
end