defmodule Kefis.Chain.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :category, :string
    field :image, :string
    field :name, :string
    field :price, :integer
    field :sku, :string
    belongs_to :partner, Kefis.Chain.Partner
    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :sku, :category, :image])
    |> validate_required([:name, :price, :sku, :category, :image])
  end
end
