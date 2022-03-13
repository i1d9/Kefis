defmodule KefisWeb.RetailerController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner
  alias Kefis.Chain.Product


  def index(conn, _params) do

    text conn, "Hello"
  end

  def order(conn, _params) do

  end

  def make_order(conn, _params) do

  end


end
