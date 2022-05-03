defmodule KefisWeb.Warehouse.IncomingLive do
  use KefisWeb, :live_component
  alias Kefis.Warehouses
  alias Kefis.Collections

  def update(%{details: details} = _assigns, socket) do
    {:ok,
     socket
     |> assign(:warehouse, details.warehouse)
     |> init_items(details.warehouse)}
  end

  def handle_event(
        "confirm",
        %{"id" => id} = _value,
        %{assigns: %{warehouse: warehouse}} = socket
      ) do
    IO.inspect(id)

    collection = Collections.get(id)

    case Collections.update(collection, %{status: "processed"}) do
      {:ok, _collection} ->
        {:noreply,
         socket
         |> init_items(warehouse)}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div class="card border-0 shadow mb-4">
    <div class="card-body">

    <h1>Incoming Orders</h1>


    <table class="table table-centered table-nowrap mb-0 rounded">
    <thead>
    <tr>
    <th>#</th>
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
    <td><%= index %></td>
    <td phx-value-id={item.id} phx-click="show_item">

      <%= item.driver.user.first_name %>
      <%= item.driver.user.second_name %>
    </td>

    <td><%= item.driver.vehicle %></td>
        <td><%= item.value %></td>

      <td>
      <button phx-click="confirm" phx-value-id={item.id} phx-target={@myself} class="btn btn-primary" type="button">Confirm</button>
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

  defp init_items(socket, warehouse) do
    items = Warehouses.incoming_orders(warehouse)
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
