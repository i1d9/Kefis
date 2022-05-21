defmodule KefisWeb.Auth do
  import import Phoenix.Controller, only: [redirect: 2]
  alias KefisWeb.Router.Helpers, as: Routes
  alias KefisWeb.Router.Helpers, as: Routes
  import Phoenix.Controller
  import Plug.Conn

  @moduledoc """
  Plug that associates
  """

  def init(opts) do
    opts
  end

  def call(conn, _role) do
    conn
  end

  def landing_page(conn, user) do
    cond do
      user.role == "super" ->
        redirect(conn, to: Routes.live_path(conn, KefisWeb.Admin.IndexLive))

      user.role == "supplier_admin" ->
        redirect(conn, to: Routes.index_path(conn, :supplier_home))

      user.role == "retailer_admin" ->
        redirect(conn, to: Routes.live_path(conn, KefisWeb.Retailer.IndexLive))

      user.role == "driver" ->
        redirect(conn, to: Routes.dashboard_path(conn, :index))

      user.role == "warehouse_admin" ->
        redirect(conn, to: Routes.live_path(conn, KefisWeb.Warehouse.IndexLive))

      true ->
        redirect(conn, to: Routes.page_path(conn, :index))
    end
  end

  def retailer(conn, _opts) do
    if conn.assigns.current_user.role == "retailer_admin" do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> Pow.Plug.delete()
      |> redirect(to: Routes.login_path(conn, :new))
      |> halt()
    end
  end

  def admin(conn, _opts) do
    if conn.assigns.current_user.role == "admin" do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> Pow.Plug.delete()
      |> redirect(to: Routes.login_path(conn, :new))
      |> halt()
    end
  end

  def supplier(conn, _opts) do
    if conn.assigns.current_user.role == "supplier_admin" do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> Pow.Plug.delete()
      |> redirect(to: Routes.login_path(conn, :new))
      |> halt()
    end
  end

  def driver(conn, _opts) do
    if conn.assigns.current_user.role == "driver" do
      IO.puts("Driver is logged")
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> Pow.Plug.delete()
      |> redirect(to: Routes.login_path(conn, :new))
      |> halt()
    end
  end

  def warehouse(conn, _opts) do
    if conn.assigns.current_user.role == "warehouse_admin" do
      IO.puts("Warehouse is logged")
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> Pow.Plug.delete()
      |> redirect(to: Routes.login_path(conn, :new))
      |> halt()
    end
  end
end
