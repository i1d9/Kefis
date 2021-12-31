defmodule Kefis.Chain.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :value, :integer
    field :status, :string
    has_many :order_details, Kefis.Chain.OrderDetail
    has_one :dispatch, Kefis.Chain.Dispatch

    belongs_to :partner, Kefis.Chain.Partner
    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [:value, :status])
    |> validate_required([:value, :status])
  end

end
