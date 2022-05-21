defmodule KefisWeb.Admin.Order.DetailComponent do
  use KefisWeb, :live_component

  alias Kefis.Orders
  alias Kefis.Drivers
  alias Kefis.Warehouses
  alias Kefis.Chain.Collection
  alias Kefis.Chain.OrderDetail
  alias Kefis.Collections

  def update(%{order_detail_id: order_detail_id, id: order_id} = _assigns, socket) do
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
     |> check_confirmed(detail)}
  end

  defp load_drivers(socket) do
    socket
    |> assign(:drivers, Drivers.admin_load_driver())
  end

  defp load_collection_changeset(socket) do
    changeset = Collection.changeset(%Collection{}, %{})

    socket
    |> assign(:collection_changeset, changeset)
  end

  defp load_warehouse(socket) do
    socket
    |> assign(:warehouses, Warehouses.list())
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
    {:noreply, socket}
  end

  def handle_event("select_warehouse", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end

  def handle_event("collection_update", %{"_target" => target} = params, socket) do
    case Enum.at(target, 0) do
      "driver" ->
        %{"driver" => driver} = params

        {:noreply,
         socket
         |> assign(:driver, driver)}

      "warehouse" ->
        %{"warehouse" => warehouse} = params

        {:noreply,
         socket
         |> assign(:warehouse, warehouse)}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_event(
        "assign_driver",
        _params,
        %{
          assigns: %{
            warehouse: warehouse_id,
            driver: driver_id,
            detail: detail,
            order_id: order_id
          }
        } = socket
      ) do
    IO.inspect(socket)

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
         {:ok, updated_detail} <- Orders.update_order_detail(detail, %{status: "tbd"}) do
      {:noreply,
       socket
       |> assign(detail: updated_detail)
       |> push_patch(
         to: Routes.index_path(socket, :detail, order_id, %{detail: updated_detail.id})
       )}
    end
  end

  def render_with_status(assigns) do
    case assigns.detail.status do
      "confirmed" ->
        ~H"""
          <div class="accordion-item">
            <h2 class="accordion-header" id="headingTwo">
              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                Collected by
              </button>
            </h2>
            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionPricing">
              <div class="accordion-body">

              <table class="table table-centered table-nowrap mb-0 rounded">
              <thead class="thead-light">
              <tr>
              <th>Driver</th>
              <th>Warehouse</th>
                      <th>Action</th>
              </tr>
              </thead>
              <tbody>

              <tr>
              <form phx-change="collection_update" phx-target={@myself}>
              <td>

              <select name="driver" phx-change="select_driver">
                      <option selected disabled>--Select Driver--</option>
              <%= for driver <- @drivers do%>


              <option value={driver.id} > <%= driver.user.first_name%> <%= driver.user.second_name%> </option>
              <% end  %>
              </select>

                      </td>
                      <td>
                      <select name="warehouse" phx-change="select_warehouse">
                      <option selected disabled>--Select Warehouse--</option>
                      <%= for warehouse <- @warehouses do%>
              <option value={warehouse.id} > <%= warehouse.location_name %> </option>
              <% end  %>
              </select> </td>

              <td>
                <span phx-click="assign_driver" phx-target={@myself} class="btn btn-gray-200">Assign</span>
              </td>
              </form>
              </tr>

              </tbody>
              </table>
              </div>
            </div>
          </div>
        """

      "picked" ->
        ~H"""
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
              Collected by
            </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionPricing">
            <div class="accordion-body">
              <table class="table table-centered table-nowrap mb-0 rounded">
              <thead class="thead-light">
              <tr>
              <th>Driver</th>
              <th>Warehouse</th>

              </tr>
              </thead>
              <tbody>

              <tr>
              <td>
               <%= @driver.user.first_name%> <%= @driver.user.second_name%>


                      </td>
              <td>
                <%= @warehouse.location_name %>
             </td>



              </tr>

              </tbody>
              </table>
            </div>
          </div>
        </div>
        """

      _ ->
        ""
    end
  end
end
