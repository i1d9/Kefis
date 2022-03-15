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

    changeset = Product.changeset(%Product{}, %{})
    render(conn, "product_new.html", changeset: changeset)
  end



  def list_partner_products(conn, _opts) do

  end

  def new_product(conn, _opts) do

  end

  @doc """
    case  Products.create(conn.assigns.current_user, product_params) do
      {:ok, _product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: Routes.partner_path(conn, :list_partner_products))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new_product.html", changeset: changeset)
    end


    if upload = product_params["image"] do
      extension = Path.extname(upload.filename)
      #String.replace("Ian Nalyanya", " ", "_")
      upload_destination = Path.join(Kefis.product_uploads_priv_dir(), "#{upload.filename}")
      File.cp(upload.path, upload_destination)
    end
  """
  def create_product(conn, %{"product" => product_params}) do
    IO.inspect(product_params)

    redirect(conn, to: Routes.supplier_path(conn, :index))


  end

  def delete_product(conn, %{"id" => id}) do

  end
end
