defmodule Kefis.Repo.Migrations.CreateSaleDetails do
  use Ecto.Migration

  def change do
    create table(:sale_details) do
      add :price, :integer
      add :quantity, :integer
      add :total, :integer
      add :sale_id, references(:sales, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:sale_details, [:sale_id])
    create index(:sale_details, [:product_id])
  end
end
