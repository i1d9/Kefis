defmodule KefisWeb.AdminController do

  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Users.User
  alias Kefis.Partners
  alias Kefis.Chain.Warehouse
  alias Kefis.Warehouses
  alias Kefis.Orders
  alias Kefis.Repo
  alias Kefis.Products
  alias Kefis.Chain.Product


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
        |> redirect(to: Routes.admin_path(conn, :list_partners))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_partner_user.html", changeset: changeset)
    end
    #partner_user_changeset = User.admin_changeset(%User{}, %{})
    #render(conn, "new_user.html", changeset: partner_user_changeset)

  end


  def edit_partner(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    changeset = Chain.change_partner(partner)
    render(conn, "edit.html", partner: partner, changeset: changeset)
  end

  def update_partner(conn, %{"id" => id, "partner" => partner_params}) do
    partner = Chain.get_partner!(id)

    case Chain.update_partner(partner, partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner updated successfully.")
        |> redirect(to: Routes.partner_path(:show, partner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", partner: partner, changeset: changeset)
    end
  end

  def list_partners(conn, _opts) do

    partners = Chain.list_partners()
    render(conn, "partner_index.html", partners: partners)
  end


  def delete_partner(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    {:ok, _partner} = Chain.delete_partner(partner)

    conn
    |> put_flash(:info, "Partner deleted successfully.")
    |> redirect(to: Routes.admin_path(conn, :list_partners))
  end

  @doc """
  Warehouse Actions
  """
  def list_warehouse(conn, _opts) do
    warehouses = Warehouses.list()
    render(conn, "warehouse_index.html", warehouses: warehouses)
  end

  def new_warehouse(conn, _opts) do
    warehouse_changeset = Warehouse.changeset(%Warehouse{}, %{})
    render(conn, "warehouse_new.html", changeset: warehouse_changeset)
  end


  def create_warehouse(conn, %{"warehouse" => warehouse}) do
    case Warehouses.create(warehouse) do
      {:ok, _warehouse} ->
        redirect(conn, to: Routes.admin_path(conn, :list_warehouse))
      {:error, %Ecto.Changeset{} = warehouse_changeset} ->
        render(conn, "warehouse_new.html", changeset: warehouse_changeset)
    end
  end

  def delete_warehouse(conn, _opts) do
    warehouses = Warehouses.list()
    render(conn, "warehouse_index.html", warehouses: warehouses)
  end


  ###API
  def api_list_partners(conn, _opts) do
    partners = Chain.list_partners()


    conn
    |> render("partners.json", partners: partners)
  end

  def api_show_partner(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)


    conn
    |> render("show.json", partner: partner)
  end

  def api_show_partner_w_products(conn, %{"id" => id}) do
    partner = Partners.show_partner_products(id)

    conn
    |> render("partner_w_products.json", partner: partner)
  end


  def api_list_orders(conn, _opts) do
    orders = Orders.admin_list_orders()
    conn
    |> render("orders.json", orders: orders)
  end

  def api_show_order(conn, %{"id" => id}) do
    order = Orders.admin_show_order(id)

    conn
    |> render("order.json", order: order)
  end


  def api_add_partner(conn, %{"partner"=> partner = %{"user" => user}}) do

    case Partners.api_create_partner(partner, user) do
       {:ok, partner} ->
        conn
        |> render("admin_partner.json", partner: partner)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KefisWeb.ErrorView, "error.json", changeset: changeset)
    end
  end

  def api_admin_show_partner(conn, %{"id" => id}) do
    partner = Repo.get(Partner, id) |> Repo.preload(:user)
    conn
    |> render("admin_partner.json", partner: partner)
  end

  def api_update_partner(conn, %{"id" => id, "partner" => partner_info} = _opts) do

    partner = Repo.get(Partner, id)

    case Chain.update_partner(partner, partner_info) do
      {:ok, partner} ->
        IO.inspect(partner)
        conn
        |> render("partner.json", partner: partner)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KefisWeb.ErrorView, "error.json", changeset: changeset)
    end

  end

  def api_delete_partner(conn, %{"id" => id} = _opts) do

    partner = Repo.get(Partner, id)
    case Partners.api_delete_partner(partner) do
      {:ok, _partner} ->
        json(conn, %{success: true, message: "Partner Deleted Successfully"})
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KefisWeb.ErrorView, "error.json", changeset: changeset)
    end

  end


  def api_add_product(conn, %{"id" => id, "product" => product }= _opts) do
    IO.inspect(id)
    IO.inspect(product)
    partner = Repo.get(Partner, id)
    case Products.create(partner, product) do
      {:ok, _product} ->
        json(conn, %{success: true, message: "Product Created Successfully"})
      {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render(KefisWeb.ErrorView, "error.json", changeset: changeset)
    end
  end


  def api_update_product(conn, %{"id" => _supplier_id, "product" => product_info, "product_id" => product_id }= _opts) do

    product = Repo.get(Product, product_id)
    IO.inspect(product)
    case Chain.update_product(product, product_info) do
      {:ok, _product} ->
        json(conn, %{success: true, message: "Product Updated Successfully"})
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KefisWeb.ErrorView, "error.json", changeset: changeset)
    end


  end

  def api_delete_product(conn, "product_id" => product_id) do
    IO.inspect(opts)
    text conn, "SDkdklds"
  end


end
