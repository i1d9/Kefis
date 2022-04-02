defmodule KefisWeb.Admin.Order.DetailComponent do
  use KefisWeb, :live_component

  alias Kefis.Orders
  alias Kefis.Drivers
  alias Kefis.Warehouses
  alias Kefis.Chain.Collection
  alias Kefis.Chain.OrderDetail
  alias Kefis.Collections

  def update(%{ order_detail_id: order_detail_id, id: order_id} = _assigns, socket) do
    detail = Orders.admin_order_detail(order_detail_id)


    product = detail.product
    supplier = detail.partner

    {:ok,
    socket
    |> assign(detail: detail)
    |> assign(product: product)
    |> assign(supplier: supplier)
    |> assign(order_id: order_id)
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






  def handle_event("select_driver", params, socket) do
    IO.inspect(params)
    {:noreply,
    socket


    }
  end

  def handle_event("select_warehouse", params, socket) do
    IO.inspect(params)
    {:noreply,
    socket


    }
  end

  def handle_event("collection_update", %{"_target" => target} = params, socket) do
    case Enum.at(target, 0) do
      "driver" ->
        %{"driver" => driver} = params
        {:noreply,
        socket
        |> assign(:driver, driver)
        }
      "warehouse" ->
        %{"warehouse" => warehouse} = params
        {:noreply,
        socket
        |> assign(:warehouse, warehouse)
        }
      _ ->
        {:noreply,
        socket
       }
    end
  end

  def handle_event("assign_driver", _params, %{assigns: %{warehouse: warehouse_id, driver: driver_id, detail: detail, order_id: order_id}} = socket) do


    collection_info = %{
      status: "initated",
      value: detail.quantity * detail.price
    }
    collection_changeset =
      Collection.changeset(%Collection{}, collection_info)
      |> Ecto.Changeset.put_assoc(:driver, Drivers.get(String.to_integer(driver_id)))
      |> Ecto.Changeset.put_assoc(:warehouse, Warehouses.show(String.to_integer(warehouse_id)))
      |> Ecto.Changeset.put_assoc(:order_detail, detail)


    IO.inspect(collection_changeset)

    with {:ok, _collection} <- Collections.new(collection_changeset),
        {:ok, updated_detail} <- Orders.update_order_detail(detail, %{status: "tbd"})
      do
        {:noreply,
        socket
        |> assign(detail: updated_detail)
        |> push_patch(to: Routes.show_path(socket, :view_detail, order_id, %{detail: updated_detail.id}))
        }


    end




  end

end
