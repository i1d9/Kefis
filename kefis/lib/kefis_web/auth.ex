defmodule KefisWeb.Auth do


  import import Phoenix.Controller, only: [redirect: 2]
  alias KefisWeb.Router.Helpers, as: Routes

  @moduledoc """
  Plug that associates
  """


  def landing_page(conn, user) do
    cond do
      user.role == "super" ->
        redirect(conn, to: Routes.admin_path(conn, :index))
      user.role == "supplier_admin" ->
        redirect(conn, to: Routes.partner_path(conn, :index))
      user.role == "retailer_admin" ->
        redirect(conn, to: Routes.partner_path(conn, :index))
      true ->
        IO.puts("Homepage")
    end
    IO.inspect(user.role)
    redirect(conn, to: Routes.page_path(conn, :index))
  end
end
