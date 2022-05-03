defmodule KefisWeb.Warehouse.ProcessedLive do
  use KefisWeb, :live_component

  alias Kefis.Warehouses
  alias Kefis.Collections

  def update(%{details: details} = _assigns, socket) do
    {:ok,
     socket
     |> init_items(details.warehouse)}
  end

  defp init_items(socket, warehouse) do
    items = Collections.processed_collection(warehouse)
    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    socket
    |> assign(:items, items)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_items, paginated_items)
    |> assign(:items_for_page, items_for_page)
    |> assign(:page_entries, page_entries)
  end

  def handle_event("check_order", %{"order" => order} = _value, socket) do
    IO.inspect(order)
    {:noreply,
     socket
     |> push_redirect(
       to:
         Routes.live_path(socket, KefisWeb.Warehouse.ShowDetailLive, %{
           "id" => order,
           "type" => "processing"
         })
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="card border-0 shadow mb-4">
    <div class="card-body">

    <h1>Processed Orders</h1>
    <table class="table table-centered table-nowrap mb-0 rounded">
    <thead class="thead-light">
    <tr>
    <th>#</th>
    <th>Retailer</th>
    <th>Value</th>
    <th>Actions</th>
    </tr>
    </thead>
    <tbody>

    <%= if @total_entries > 0 do%>

    <%= for {%{order_detail: %{order: %{partner: retailer }=order} = order_detail}=item, index} <- Enum.with_index(@items_for_page, 1) do%>
    <tr>
    <td phx-click="check_order" phx-value-order={order.id} phx-target={@myself}>
    <%= index %>
    </td>
    <td>
    <%= retailer.name %>
    </td>


    <td>
    <%= order.value %>
    </td>
    </tr>


    <% end %>
    <% end %>

    </tbody>
    </table>

    </div>
    </div>
    """
  end
end
