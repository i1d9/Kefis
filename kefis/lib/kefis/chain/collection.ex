defmodule Kefis.Chain.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do

    field :value, :integer
    field :status, :string

    belongs_to :driver, Kefis.Chain.Driver
    belongs_to :order_detail, Kefis.Chain.OrderDetail
    belongs_to :partner, Kefis.Chain.Partner
    belongs_to :warehouse, Kefis.Chain.Warehouse
    belongs_to :dispatch, Kefis.Chain.Dispatch

    timestamps()

  end

  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:status, :value])
    |> validate_required([:status, :value])
  end
end
