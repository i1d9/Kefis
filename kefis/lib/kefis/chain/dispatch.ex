defmodule Kefis.Chain.Dispatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dispatches" do
    belongs_to :warehouse, Kefis.Chain.Warehouse
    belongs_to :driver, Kefis.Chain.Driver
    belongs_to :order, Kefis.Chain.Order

    has_many :dispatch_details, Kefis.Chain.DispatchDetails
    has_many :collections, Kefis.Chain.Collection

    field :status, :string

    timestamps()
  end

  def changeset(dispatch, attrs) do
    dispatch
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
