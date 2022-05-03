defmodule Kefis.POS.SaleDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sale_details" do
    field :price, :integer
    field :quantity, :integer
    field :total, :integer
    field :sale_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(sale_detail, attrs) do
    sale_detail
    |> cast(attrs, [:price, :quantity, :total])
    |> validate_required([:price, :quantity, :total])
  end
end
