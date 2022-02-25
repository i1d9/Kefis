defmodule Kefis.Repo.Migrations.AddCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do

      add :order_detail_id, references(:order_details)
      add :driver_id, references(:drivers)
      add :warehouse_id, references(:warehouses)
      add :partner_id, references(:partners)#Supplier ID
      add :value, :integer
      add :status, :string

      timestamps()

    end

  end
end
