defmodule Kefis.Chain.Supplier do
  use Ecto.Schema
  import Ecto.Changeset

  schema "suppliers" do
    field :email, :string
    field :lat, :float
    field :lng, :float
    field :location, :string
    field :name, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(supplier, attrs) do
    supplier
    |> cast(attrs, [:name, :location, :phone, :email, :lng, :lat])
    |> validate_required([:name, :location, :phone, :email, :lng, :lat])
  end
end
