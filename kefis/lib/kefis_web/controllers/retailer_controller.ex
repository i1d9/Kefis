defmodule KefisWeb.RetailerController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Chain.Product
  alias Kefis.Orders


  def index(conn, _params) do

    text conn, "Hello"
  end

  def order(%{assigns: %{current_user: current_user}}= conn, _params) do

    IO.inspect(current_user)
    live_render(conn, KefisWeb.Retailer.NewOrderLive, session: %{
      "current_user" => current_user
    })
  end

  def show_order(conn, %{"id" => id}) do

    case Orders.get_order(id) do
      nil ->
        conn
        |> put_flash(:error, "Order not found!")
        |> redirect(to: Routes.retailer_path(conn, :index))

      order -> live_render(conn, KefisWeb.Retailer.ConfirmOrderLive, session: %{
        "order" => order
      })

    end

  end


end
