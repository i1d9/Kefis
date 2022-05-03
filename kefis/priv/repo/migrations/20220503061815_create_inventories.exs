defmodule Kefis.Repo.Migrations.CreateInventories do
  use Ecto.Migration

  def change do
    create table(:inventories) do
      add :quantity, :integer
      add :margin, :integer
      add :product_id, references(:products, on_delete: :nothing)
      add :partner_id, references(:partners, on_delete: :nothing)

      timestamps()
    end

    create index(:inventories, [:product_id])
    create index(:inventories, [:partner_id])
  end
end
