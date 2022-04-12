defmodule Kefis.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema
  import Ecto.Changeset

  @roles ~w(user super supplier_admin supplier_user retailer_admin retailer_user driver warehouse_admin warehouse_user)

  schema "users" do
    pow_user_fields()
    field :role, :string, default: "user"
    field :first_name, :string
    field :second_name, :string
    field :phone, :string

    has_one :partner, Kefis.Chain.Partner
    has_one :driver, Kefis.Chain.Driver
    has_one :warehouse, Kefis.Chain.Warehouse

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:role, :first_name, :second_name, :phone])
    |> validate_inclusion(:role, @roles)
    |> validate_required([:first_name, :second_name, :phone])
    |> validate_length(:phone, min: 10, max: 12)
  end

  def admin_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> cast(attrs, [:role, :first_name, :second_name, :phone])
    |> validate_inclusion(:role, @roles)
    |> validate_required([:first_name, :second_name, :phone])
    |> validate_length(:phone, min: 10, max: 12)
  end

  def role_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> cast(attrs, [:role])
    |> validate_inclusion(:role, @roles)
  end

end
