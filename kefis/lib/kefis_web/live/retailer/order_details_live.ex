defmodule KefisWeb.Retailer.OrderDetailsLive do
  use KefisWeb, :live_component

  alias Kefis.Chain.Order
  alias Kefis.Chain.OrderDetail
  alias Kefis.Orders

  def update(%{details: %{order_detail_id: order_id}} = _as, socket) do

    {:ok,
    socket
    |> init_items(order_id)
    }
  end

  defp init_items(socket, order_id) do

    order = Orders.get_order(order_id)
    items = order.order_details

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


  def render(assigns) do
    ~H"""
    <div>

      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center py-4">
      <div class="d-block mb-4 mb-md-0">
        <nav aria-label="breadcrumb" class="d-none d-md-inline-block">
          <ol class="breadcrumb breadcrumb-dark breadcrumb-transparent">
            <li class="breadcrumb-item">
              <a href="#">
                <svg class="icon icon-xxs" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6">
                  </path>
                </svg>
              </a>
            </li>
            <li class="breadcrumb-item"><a href="#">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">All Orders</li>
          </ol>
        </nav>
        <h2 class="h4"></h2>
        <p class="mb-0"> Order Details </p>
      </div>
    </div>

      <div class="py-4">
        <button type="button" class="btn btn-primary" phx-click="show_orders">Back</button>
      </div>

      <div class="card border-0 shadow mb-4">
      <div class="card-body">

        <div>

        </div>
        <div class="table-responsive">
          <table class="table table-centered table-nowrap mb-0 rounded">
            <thead>
              <tr>
                <th class="border-0">#</th>
                <th phx-click="table_filter" phx-value-="name">
                Name
                </th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Supplier</th>
                <th phx-click=""> Status</th>
              </tr>
            </thead>
            <tbody>

            <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
            <tr>
            <td phx-value-id={item.id}>
              <%= index %>
            </td>

            <td><%= item.product.name %></td>
            <td><%= item.price %></td>
            <td><%= item.quantity %></td>
            <td><%= item.partner.name %></td>
            <td><%= item.status %></td>

            </tr>
            <% end %>

            </tbody>
          </table>
        </div>
      </div>
      </div>



    </div>
    """
  end





end
