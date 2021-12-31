defmodule Kefis.Repo.Migrations.AddOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :value, :integer
      add :status, :string
      add :partner_id, references(:partners)#Retailer

      timestamps()
    end
  end
end
