defmodule KefisWeb.Admin.Order.DetailComponent do
  use KefisWeb, :live_component

  alias Kefis.Orders
  alias Kefis.Drivers
  alias Kefis.Warehouses
  alias Kefis.Chain.Collection

  def update(%{ order_detail_id: order_detail_id} = assigns, socket) do
    detail = Orders.admin_order_detail(order_detail_id)

    product = detail.product
    supplier = detail.partner
    IO.inspect(assigns)
    {:ok,
    socket
    |> assign(detail: detail)
    |> assign(product: product)
    |> assign(supplier: supplier)
    |> check_collection(detail)
    |> check_confirmed(detail)


    }
  end


  defp load_drivers(socket) do
    socket
    |> assign(:drivers, Drivers.admin_load_driver)
  end

  defp load_collection_changeset(socket) do
    changeset = Collection.changeset(%Collection{}, %{})
    socket
    |> assign(:collection_changeset, changeset)

  end

  defp load_warehouse(socket) do
    socket
    |> assign(:warehouses, Warehouses.list)
  end

  defp check_collection(socket, detail) do
    if detail.collection do
      assign(socket, :collection, detail.collection)
    else
      socket
    end
  end

  def check_confirmed(socket, detail) do
    case detail.status do
      "confirmed" ->
        socket
        |> load_drivers()
        |> load_warehouse()
        |> load_collection_changeset()
      _ ->
        socket
    end
  end





  def handle_event("assign_collection", _value, socket) do
    {:noreply, socket}
  end







end
