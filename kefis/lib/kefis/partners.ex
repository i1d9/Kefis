defmodule Kefis.Partners do
  alias Kefis.Repo
  alias Kefis.Users.User
  alias Kefis.Chain.Partner
  alias Ecto.Changeset

  def create_partner_user(partner_details, user_details) do

    user_changeset = User.admin_changeset(%User{}, add_role(partner_details, user_details))
    partner_changeset = Partner.changeset(%Partner{}, partner_details)

    IO.inspect(user_details)
    IO.inspect(user_changeset)

    user_changeset
    |> Changeset.put_assoc(:partner, partner_changeset)
    |> Repo.insert()
  end

  def add_role(partner, user_details) do
    if partner["type"] == "retailer" do
      user_details = Map.put(user_details, "role", "retailer_admin")
      user_details
    else
      user_details = Map.put(user_details, "role", "supplier_admin")
      user_details
    end
  end

  def create_partner(details) do
    IO.inspect(Partner.changeset(%Partner{}, details))

    if Partner.changeset(%Partner{}, details).valid? do
      {:ok, details}
    else
      partner_changeset = Partner.changeset(%Partner{}, details)
      {:error, partner_changeset}
    end
  end


  def show_partner_products(id) do
    Repo.get(Partner, id) |> Repo.preload(:products)
  end
end
