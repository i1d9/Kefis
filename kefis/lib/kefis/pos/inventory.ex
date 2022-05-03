defmodule Kefis.POS.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventories" do
    field :margin, :integer
    field :quantity, :integer
    field :product_id, :id
    field :partner_id, :id

    timestamps()
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:quantity, :margin])
    |> validate_required([:quantity, :margin])
  end
end
