defmodule Kefis.Chain.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :category, :string
    field :image, :string, default: "/images/product_placeholder.jpg"
    field :name, :string
    field :price, :integer
    field :sku, :string
    field :package, :string
    belongs_to :partner, Kefis.Chain.Partner
    has_many :order_details, Kefis.Chain.OrderDetail

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :sku, :category, :image, :package])
    |> validate_required([:name, :price, :sku, :category, :image, :package])
  end
end
