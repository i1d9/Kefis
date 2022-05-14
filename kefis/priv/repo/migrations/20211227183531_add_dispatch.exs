defmodule Kefis.Repo.Migrations.AddDispatch do
  use Ecto.Migration

  def change do
    create table(:dispatches) do
      add :order_id, references(:orders)
      add :warehouse_id, references(:warehouses)
      add :driver_id, references(:drivers)
      add :status, :string
      add :date, :date

      timestamps()
    end
  end
end
