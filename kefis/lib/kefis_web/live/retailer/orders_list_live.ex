defmodule KefisWeb.Retailer.OrdersListLive do
  use KefisWeb, :live_component

  alias Kefis.Orders

  def update(%{details: %{user: user, live_action: live_action} }= assign, socket) do

    {:ok,
    socket
    |> init_items(user)
    |> assign(:live_action, live_action)
    |> assign(:show_detail, 1)
    }
  end


  defp init_items(socket, user) do

    items = Orders.retailer_orders(user)

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




  @impl true
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
          <p class="mb-0"> Request for items for your shop </p>
        </div>
      </div>

      <div class="py-4">
        <button type="button" phx-click="toggle_finished" phx-target={@myself} class="btn btn-gray-800 d-inline-flex align-items-center me-2">New</button>
      </div>

      <div class="card border-0 shadow mb-4">
        <div class="card-body">



          <div class="table-responsive">
            <table class="table table-centered table-nowrap mb-0 rounded">
              <thead>
                <tr>
                  <th class="border-0">#</th>
                  <th class="border-0">Value</th>
                  <th class="border-0">Items</th>
                  <th class="border-0">Status</th>
                  <th class="border-0">Created on</th>
                </tr>
              </thead>
              <tbody>
                <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
                <tr>
                <td phx-value-id={item.id} phx-click="show_item">
                  <%= index %>
                </td>
                <td>
                  <%= item.value %>
                </td>

                <td>
                  <%= Enum.count(item.order_details) %>
                </td>


                <td>
                  <%= item.status %>
                </td>

                <td>

                  <%= Date.to_iso8601(item.inserted_at) %>
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
      </div>

    </div>
    """
  end
end
