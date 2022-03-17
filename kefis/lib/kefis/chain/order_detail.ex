defmodule Kefis.Chain.OrderDetail do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_details" do
    belongs_to :partner, Kefis.Chain.Partner
    belongs_to :product, Kefis.Chain.Product
    belongs_to :order, Kefis.Chain.Order

    has_one :collection, Kefis.Chain.Collection

    field :quantity, :integer
    field :status, :string
    field :price, :integer

    timestamps()
  end

  def changeset(details, attrs) do
    details
    |> cast(attrs, [:quantity, :status, :price])
    |> validate_required([:quantity, :status, :price])
  end
end
