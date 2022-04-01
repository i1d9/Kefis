defmodule KefisWeb.SupplierController do

  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Users.User
  alias Kefis.Partners
  alias Kefis.Products
  alias Kefis.Orders
  alias Kefis.Chain.Product
  alias Kefis.Repo





  def index(conn, _opts) do



    render(conn, "index.html")
  end



  def list_partner_products(%{assigns: %{current_user: current_user}}= conn, _opts) do
    user = current_user |> Repo.preload([:partner, :account])

    partner = user.partner

    render(conn, "products.html", user: user, partner: partner)
  end

  def new_product(conn, _opts) do
    changeset = Product.changeset(%Product{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
    case Products.create(conn.assigns.current_user, product_params) do
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

      File.cp(upload.path, upload_destination)
    end
  """
  def create_product(conn, %{"product" => product_params}) do

    logged_user = Repo.get!(User, conn.assigns.current_user.id) |> Repo.preload([:partner])


    if upload = product_params["image"] do
      extension = Path.extname(upload.filename)
      image_name = "#{String.replace(product_params["name"], " ", "_")}#{extension}"
      updated_product_params = Map.put(product_params, "image", image_name)


      case  Products.create(logged_user.partner, updated_product_params) do
        {:ok, product} ->
          IO.inspect(product)

          upload_destination = Path.join(Kefis.product_uploads_priv_dir(), product.image)
          File.cp(upload.path, upload_destination)

          conn
          |> put_flash(:info, "Product created successfully.")
          |> redirect(to: Routes.supplier_path(conn, :index))

        {:error, %Ecto.Changeset{} = changeset} ->
          IO.inspect(changeset)
          render(conn, "product_new.html", changeset: changeset)
      end

    else


      product_changest = Product.changeset(%Product{}, product_params)

      changeset = Ecto.Changeset.add_error(product_changest, :image, "Can't be blank")

      IO.inspect(changeset)
      conn
      |> put_flash(:error, "No image selected")
      |> render("product_new.html", changeset: changeset)

    end

  end

  def delete_product(conn, %{"id" => id}) do

  end

  def my_orders(%{assigns: %{current_user: current_user}}= conn, _params) do


    render(conn, "orders.html", current_user: current_user)

  end


  def show_order_details(%{assigns: %{current_user: current_user}}= conn, %{"id" => id}) do

    user = current_user |> Repo.preload([:partner, :account])



    case Orders.supplier_order_detail(id, user.partner) do
      nil ->
        conn
        |> put_flash(:error, "Order not found")
        |> redirect(to: Routes.supplier_path(conn, :my_orders))
      order_detail ->
        render(conn, "order_details.html", order_detail: order_detail, user: user)




    end
  end
end
