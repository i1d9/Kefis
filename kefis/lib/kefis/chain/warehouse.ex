defmodule Kefis.Chain.Warehouse do
  use Ecto.Schema
  import Ecto.Changeset

  schema "warehouses" do
    field :location_name, :string
    field :lng, :float
    field :lat, :float
    has_many :dispatches, Kefis.Chain.Dispatch
    belongs_to :collections, Kefis.Chain.Collection
  end

  def changeset(warehouse, attrs) do
    warehouse
    |> cast(attrs, [:location_name, :lng, :lat])
    |> validate_required([:location_name, :lng, :lat])
  end
end