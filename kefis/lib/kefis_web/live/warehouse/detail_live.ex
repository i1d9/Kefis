defmodule KefisWeb.Warehouse.DetailLive do
  use KefisWeb, :live_component

  alias Kefis.Orders

  def update(%{details: %{type: type, record_id: id} = detail} = _assign, socket) do
    IO.inspect(detail)

    {:ok,
     socket
     |> assign(type: type)
     |> assign(id: id)
     |> load_data(id, type)}
  end

  defp init_items(socket, items) do
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

  def load_data(socket, id, type = "incoming") do
    socket
  end

  def load_data(socket, id, type = "processing") do
    data = Orders.warehouse_processing_order(id)
    %{partner: retailer, order_details: details} = data

    socket
    |> assign(retailer: retailer)
    |> init_items(details)
  end

  def load_data(socket, id, type = "outgoing") do
    socket
  end

  def render_by_type(assigns, type = "incoming") do
    ~H"""
    <div>
    <h1>Incoming</h1>
    </div>
    """
  end

  def render_by_type(assigns, type = "outing") do
    ~H"""
    <div>
    <h1>Outgoing</h1>

    </div>
    """
  end

  def render_by_type(assigns, type = "processing") do
    ~H"""
    <div>
      <h1>Processing</h1>

      <h1>Order Details</h1>
      <div class="table-responsive">

    <table class="table table-centered table-nowrap mb-0 rounded">
    <thead class="thead-light">
    <tr>
    <th class="border-0 rounded-start">#</th>
    <th class="border-0">Name</th>

    <th class="border-0">Price</th>

    <th class="border-0">Collected</th>
    </tr>
    </thead>
    <tbody>
    <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
    <tr>


      <td><%= index   %></td>

      <td>
      <%= if item.collection == nil do%>
        <span>-</span>
      <% else %>
      <span>Collected</span>
      <% end %>
      </td>

    </tr>
    <% end %>
    </tbody>
    </table>


    <div class="card-footer px-3 border-0 d-flex flex-column flex-lg-row align-items-center justify-content-between">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination mb-0">

    <%= unless @page_number == 0 do %>
                     <li class="page-item">
                                <span class="page-link" phx-click="previous">Previous</span>
                            </li>

    <% end %>




      <%= for {_page, index} <- Enum.with_index(@paginated_items) do%>

            <%= if @page_number == index do%>
                <li class="page-item active">
                    <span class="page-link" ><%= index + 1%></span>
                </li>
            <% else %>

            <li class="page-item">
                <span class="page-link" phx-click="change_page" phx-value-index={index} ><%= index + 1%></span>
            </li>
            <% end %>
      <% end %>



    <%= unless @page_number == @total_pages - 1 do %>
                     <li class="page-item">
                                <span class="page-link" phx-click="next">Next</span>
                            </li>

    <% end %>
                        </ul>
                    </nav>
                    <div class="fw-normal small mt-4 mt-lg-0">Showing <b>  <%= if @page_entries < 10, do: @page_entries, else: @total_entries %></b> out of <b><%= @total_entries %></b> entries</div>

                </div>
                    </div>
    </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div class="card border-0 shadow mb-4">
      <div class="card-body">
        <%= render_by_type(assigns, @type) %>
      </div>
    </div>
    """
  end
end
