defmodule Kefis.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  @roles ~w(user super supplier_admin supplier_user retailer_admin retailer_user driver)

  schema "users" do
    pow_user_fields()
    field :role, :string, default: "user"

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, @roles)
  end

  def role_changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role])
    |> Ecto.Changeset.validate_inclusion(:role, @roles)
  end

end
