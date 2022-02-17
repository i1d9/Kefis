defmodule KefisWeb.Auth do


  import import Phoenix.Controller, only: [redirect: 2]
  alias KefisWeb.Router.Helpers, as: Routes

  @moduledoc """
  Plug that associates
  """


  def landing_page(conn, user) do
    cond do
      user.role == "super" ->
        IO.puts("Render Admin Page")
      user.role == "supplier_admin" ->
        IO.puts("Supplier Dashboard")
      user.role == "retailer_admin" ->
          IO.puts("Retailer Dashboard")
      true ->
        IO.puts("Homepage")
    end
    IO.inspect(user.role)
    redirect(conn, to: Routes.page_path(conn, :index))
  end
end
