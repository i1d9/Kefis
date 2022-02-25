defmodule Kefis.Repo.Migrations.AddOrdersDetails do
  use Ecto.Migration

  def change do
    create table(:order_details) do
      add :order_id, references(:orders)
      add :product_id, references(:products)
      add :partner_id, references(:partners)#Supplier ID
      #add :collection_id, references(:collections)

      add :quantity, :integer
      add :status, :string
      add :price, :integer

      timestamps()
    end
  end
end
