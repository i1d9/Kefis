defmodule KefisWeb.Retailer.NewOrderLive do
  use Phoenix.LiveView
  alias Kefis.Products

  def mount(_params, _df, socket) do
    products = Products.list_products()

    {:ok, assign(socket, :products, products)}
  end

  @impl true
  def handle_event("type_search", session, socket) do
    IO.inspect(session)
    products = Products.list_products()
    {:noreply, assign(socket, :products, products)}
  end

  @impl true
  def handle_event("search_click", session, socket) do
    IO.inspect(session)
    products = Products.list_products()
    {:noreply, assign(socket, :products, products)}
  end

end
