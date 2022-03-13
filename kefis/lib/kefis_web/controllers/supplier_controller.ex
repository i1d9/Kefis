defmodule KefisWeb.SupplierController do

  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Users.User
  alias Kefis.Partners
  alias Kefis.Products

  alias Kefis.Chain.Product
  alias Kefis.Repo
  alias Kefis.Products


  def index(conn, _opts) do
    text conn, "Hello"
  end

  def list_partner_products(conn, _opts) do

  end

  def new_product(conn, _opts) do

  end

  def create_product(conn, %{"product" => product_params}) do

  end

  def delete_product(conn, %{"id" => id}) do

  end
end
