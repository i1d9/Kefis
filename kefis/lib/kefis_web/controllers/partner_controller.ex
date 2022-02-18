defmodule KefisWeb.PartnerController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Users.User
  alias Kefis.Partners
  alias Kefis.Products

  alias Kefis.Chain.Product
  alias Kefis.Repo
  alias Kefis.Products



  def index(conn, _params) do

    partners = Chain.list_partners()
    render(conn, "index.html", partners: partners)
  end

  def new(conn, _params) do
    changeset = Chain.change_partner(%Partner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"partner" => partner_params}) do

    case Partners.create_partner(partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner created successfully.")
        |> put_session(:partner, partner)
        |> redirect(to: Routes.partner_path(conn, :new_partner_user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end



  end

  def show(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    render(conn, "show.html", partner: partner)
  end

  def edit(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    changeset = Chain.change_partner(partner)
    render(conn, "edit.html", partner: partner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "partner" => partner_params}) do
    partner = Chain.get_partner!(id)

    case Chain.update_partner(partner, partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner updated successfully.")
        |> redirect(to: Routes.partner_path(conn, :show, partner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", partner: partner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    {:ok, _partner} = Chain.delete_partner(partner)

    conn
    |> put_flash(:info, "Partner deleted successfully.")
    |> redirect(to: Routes.partner_path(conn, :index))
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
    render(conn, "new_user.html", changeset: partner_user_changeset, partner: partner)

  end


  def create_partner_user(conn, %{"user" => user_params}) do

    partner = get_session(conn, :partner)


    case Partners.create_partner_user(partner, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User Account added successfully.")
        |> redirect(to: Routes.partner_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_user.html", changeset: changeset)
    end



    #partner_user_changeset = User.admin_changeset(%User{}, %{})
    #render(conn, "new_user.html", changeset: partner_user_changeset)

  end

  def show_partner_user(conn, %{"id" => id}) do

  end


  def list_partner_products(conn, _opts) do
    products = Products.list_partner_products(conn.assigns.current_user.partner)
    render(conn, "product_list.html", products: products)
  end

  def new_product(conn, _opts) do
    IO.inspect(conn.assigns.current_user.partner)
    changeset = Chain.change_product(%Product{})
    render(conn, "new_product.html", changeset: changeset)
  end



  def create_product(conn, %{"product" => product_params}) do
    case  Products.create(conn.assigns.current_user.partner, product_params) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: Routes.partner_path(conn, :list_partner_products))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_product.html", changeset: changeset)
    end
  end

  def show_product(conn, %{"id" => id}) do
    product = Chain.get_product!(id)
    render(conn, "show.html", product: product)
  end

  def edit_product(conn, %{"id" => id}) do
    product = Chain.get_product!(id)
    changeset = Chain.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update_product(conn, %{"id" => id, "product" => product_params}) do
    product = Chain.get_product!(id)

    case Chain.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", product: product, changeset: changeset)
    end
  end

  def delete_product(conn, %{"id" => id}) do
    product = Chain.get_product!(id)
    {:ok, _product} = Chain.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: Routes.product_path(conn, :index))
  end

end
