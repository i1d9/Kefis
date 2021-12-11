defmodule Kefis.Repo.Migrations.AddProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :integer
      add :sku, :string
      add :category, :string
      add :image, :string
      add :partner_id, references(:partners)

      timestamps()
    end
  end
end
