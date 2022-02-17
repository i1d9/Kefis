defmodule KefisWeb.AdminController do

  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Users.User
  alias Kefis.Partners


  def index(conn, _opts) do
    render(conn, "index.html")
  end


  def new_partner(conn, _opts) do
    changeset = Chain.change_partner(%Partner{})
    render(conn, "new_partner.html", changeset: changeset)
  end

  def create_new_partner(conn, %{"partner" => partner_params}) do
    case Partners.create_partner(partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner created successfully.")
        |> put_session(:partner, partner)
        |> redirect(to: Routes.admin_path(conn, :new_partner_user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_partner.html", changeset: changeset)
    end
  end


  def new_partner_user(conn, _opts) do
    partner = get_session(conn, :partner)
    IO.inspect(partner)

    empty_new = %{}

    if partner["type"] == "retailer" do
      empty_new = Map.put(empty_new, :role, "retailer_admin")
      IO.inspect(empty_new)
    else
      empty_new = Map.put(empty_new, :role, "supplier_admin")
      IO.inspect(empty_new)
    end

    partner_user_changeset = User.admin_changeset(%User{}, %{})
    render(conn, "new_partner_user.html", changeset: partner_user_changeset, partner: partner)

  end


  def create_partner_user(conn, %{"user" => user_params}) do
    partner = get_session(conn, :partner)
    case Partners.create_partner_user(partner, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User Account added successfully.")
        |> redirect(to: Routes.partner_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_partner_user.html", changeset: changeset)
    end
    #partner_user_changeset = User.admin_changeset(%User{}, %{})
    #render(conn, "new_user.html", changeset: partner_user_changeset)

  end


end
