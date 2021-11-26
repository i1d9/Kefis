defmodule KefisWeb.SupplierController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Supplier

  def index(conn, _params) do
    suppliers = Chain.list_suppliers()
    render(conn, "index.html", suppliers: suppliers)
  end

  def new(conn, _params) do
    changeset = Chain.change_supplier(%Supplier{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"supplier" => supplier_params}) do
    case Chain.create_supplier(supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier created successfully.")
        |> redirect(to: Routes.supplier_path(conn, :show, supplier))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Chain.get_supplier!(id)
    render(conn, "show.html", supplier: supplier)
  end

  def edit(conn, %{"id" => id}) do
    supplier = Chain.get_supplier!(id)
    changeset = Chain.change_supplier(supplier)
    render(conn, "edit.html", supplier: supplier, changeset: changeset)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Chain.get_supplier!(id)

    case Chain.update_supplier(supplier, supplier_params) do
      {:ok, supplier} ->
        conn
        |> put_flash(:info, "Supplier updated successfully.")
        |> redirect(to: Routes.supplier_path(conn, :show, supplier))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", supplier: supplier, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Chain.get_supplier!(id)
    {:ok, _supplier} = Chain.delete_supplier(supplier)

    conn
    |> put_flash(:info, "Supplier deleted successfully.")
    |> redirect(to: Routes.supplier_path(conn, :index))
  end
end
