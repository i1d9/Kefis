defmodule KefisWeb.TestAuth do

  alias KefisWeb.Router.Helpers, as: Routes
  import Phoenix.Controller
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _role) do
    conn
  end

  def retailer(conn, _opts) do

    if conn.assigns.current_user.role == "retailer_admin" do
      IO.puts("Retailer is logged")
      conn
    else
        conn
        |> put_flash(:error, "You must be logged in to access that page")
        |> redirect(to: Routes.login_path(conn, :new))
        |> halt()
    end
  end


  def admin(conn, _opts) do

    if conn.assigns.current_user.role == "admin" do
      IO.puts("admin is logged")
      conn
    else
        conn
        |> put_flash(:error, "You must be logged in to access that page")
        |> redirect(to: Routes.login_path(conn, :new))
        |> halt()
    end
  end

  def supplier(conn, _opts) do

    if conn.assigns.current_user.role == "supplier_admin" do
      IO.puts("Retailer is logged")
      conn
    else
        conn
        |> put_flash(:error, "You must be logged in to access that page")
        |> redirect(to: Routes.login_path(conn, :new))
        |> halt()
    end
  end


  def driver(conn, _opts) do

    if conn.assigns.current_user.role == "driver" do
      IO.puts("Retailer is logged")
      conn
    else
        conn
        |> put_flash(:error, "You must be logged in to access that page")
        |> redirect(to: Routes.login_path(conn, :new))
        |> halt()
    end
  end
end
