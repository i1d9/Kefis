defmodule Kefis.Chain.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :contact_email, :string
    field :contact_phone, :string
    field :lat, :float
    field :lng, :float
    field :location, :string
    field :name, :string
    field :phone, :string
    field :type, :string

    belongs_to :user, Kefis.Users.User

    has_many :products, Kefis.Chain.Product
    has_many :order_details, Kefis.Chain.OrderDetail
    has_many :orders, Kefis.Chain.Order
    has_many :collections, Kefis.Chain.Collection
    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:name, :location, :phone, :contact_email, :contact_phone, :lng, :lat, :type])
    |> validate_required([:name, :location, :phone, :contact_email, :contact_phone, :lng, :lat, :type])
    |> unique_constraint(:contact_email)
    |> validate_length(:phone, min: 10, max: 12)
    |> validate_format(:contact_email, ~r/@/)
    |> validate_inclusion(:type, ~w(supplier retailer))
  end
end
