defmodule Kefis.Chain.Dispatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dispatches" do

    belongs_to :warehouse, Kefis.Chain.Warehouse
    belongs_to :driver, Kefis.Chain.Driver
    belongs_to :orders, Kefis.Chain.Order
    
    has_many :dispatch_details, Kefis.Chain.DispatchDetails
    field :status, :string

  end

  def changeset(dispatch, attrs) do
    dispatch
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
