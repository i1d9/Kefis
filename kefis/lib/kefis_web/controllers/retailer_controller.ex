defmodule KefisWeb.RetailerController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Chain.Product


  def index(conn, _params) do

    text conn, "Hello"
  end

  def order(%{assigns: %{current_user: current_user}}= conn, _params) do

    IO.inspect(current_user)
    live_render(conn, KefisWeb.Retailer.NewOrderLive, session: %{
      "current_user" => current_user
    })
  end

  def make_order(conn, _params) do

  end


end
