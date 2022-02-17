defmodule KefisWeb.ProductController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Product
  alias Kefis.Repo
  alias Kefis.Users.User


  plug KefisWeb.Authorize, resource: Kefis.Chain.Product

  def index(conn, _params) do
    #IO.inspect(conn)
    products = Chain.list_products()
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Chain.change_product(%Product{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do


    case Chain.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: Routes.product_path(conn, :show, product))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Chain.get_product!(id)
    render(conn, "show.html", product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Chain.get_product!(id)
    changeset = Chain.change_product(product)
    render(conn, "edit.html", product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
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

  def delete(conn, %{"id" => id}) do
    product = Chain.get_product!(id)
    {:ok, _product} = Chain.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: Routes.product_path(conn, :index))
  end
end
