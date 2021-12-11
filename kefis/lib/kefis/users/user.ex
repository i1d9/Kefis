defmodule Kefis.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  @roles ~w(user super supplier_admin supplier_user retailer_admin retailer_user driver)

  schema "users" do
    pow_user_fields()
    field :role, :string, default: "user"
    field :first_name, :string
    field :second_name, :string
    field :phone, :string
    has_one :partner, Kefis.Chain.Partner
    has_one :account, Kefis.Chain.Account
    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:role, :first_name, :second_name, :phone])
    |> Ecto.Changeset.validate_inclusion(:role, @roles)
    |> Ecto.Changeset.validate_required([:first_name, :second_name, :phone])
  end

  def registration_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:role, :first_name, :second_name, :phone])
    |> Ecto.Changeset.validate_inclusion(:role, @roles)
    |> Ecto.Changeset.validate_required([:first_name, :second_name, :phone])
  end

  def role_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, @roles)
  end

end
