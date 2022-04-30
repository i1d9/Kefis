defmodule KefisWeb.Warehouse.IncomingLive do
  use KefisWeb, :live_component
  alias Kefis.Warehouses

  def update(%{details: details} = assigns, socket) do
    IO.inspect(details.warehouse)
    {:ok,
     socket
     |> init_items(details.warehouse)}
  end

  def render(assigns) do
    ~H"""
    <div>
    <h1>Incoming Orders</h1>
    <table class="table table-centered table-nowrap mb-0 rounded">
    <thead>
    <tr>
    <th>Driver</th>
    <th>Vehicle</th>
    <th>Value</th>
    <th>Actions</th>
    </tr>
    </thead>
    <tbody>

    <%= if @total_entries > 0 do%>

    <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
    <tr>
    <td phx-value-id={item.id} phx-click="show_item">

      <%= item.driver.user.first_name %>
      <%= item.driver.user.second_name %>
    </td>

    <td><%= item.driver.vehicle %></td>
        <td><%= item.value %></td>
    </tr>
    <% end %>
    <% end %>

    </tbody>
    </table>
    </div>
    """
  end

  defp init_items(socket, warehouse) do
    items = Warehouses.incoming_orders(warehouse)
    IO.inspect(items)
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
end
