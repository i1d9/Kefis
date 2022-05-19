defmodule KefisWeb.Supplier.Order.ListComponent do
  use KefisWeb, :live_component

  alias Kefis.Repo
  alias Kefis.Orders


  def update(%{details: assigns}, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> init_items()
    }
  end

  defp init_items(socket, status \\ "initiated") do
    orders = Orders.supplier_orders(socket.assigns.supplier, status)

    page_entries = 10
    paginated_orders = orders |> Enum.chunk_every(page_entries)
    orders_for_page = paginated_orders |> Enum.at(0)
    total_entries = orders |> Enum.count()
    total_pages = paginated_orders |> Enum.count()

    socket
    |> assign(:orders, orders)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_orders, paginated_orders)
    |> assign(:orders_for_page, orders_for_page)
    |> assign(:page_entries, page_entries)
  end

  def handle_event(
        "change_page",
        %{"index" => index} = _params,
        %{assigns: %{paginated_orders: paginated_orders}} = socket
      ) do
    orders_for_page = paginated_orders |> Enum.at(String.to_integer(index))
    page_entries = orders_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, String.to_integer(index))
     |> assign(:orders_for_page, orders_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{assigns: %{page_number: page_number, paginated_orders: paginated_orders}} = socket
      ) do
    orders_for_page = paginated_orders |> Enum.at(page_number + 1)
    page_entries = orders_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number + 1)
     |> assign(:orders_for_page, orders_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{assigns: %{page_number: page_number, paginated_orders: paginated_orders}} = socket
      ) do
    orders_for_page = paginated_orders |> Enum.at(page_number - 1)
    page_entries = orders_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number - 1)
     |> assign(:orders_for_page, orders_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event("order", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("filter_status", %{"status" => status}, %{assigns: %{user: current_user}}=socket) do
    IO.inspect(status)
    IO.inspect(current_user)

    {:noreply,
    socket
    |> init_items(status)
    }
  end

  def render(assigns) do
    ~H"""
    <div class="table-settings mb-4">

    <div class="row align-items-center justify-content-between">
        <div class="col col-md-6 col-lg-3 col-xl-4">
          <div class="input-group me-2 me-lg-3 fmxw-400">
            <%= form_for :search, "#", [phx_change: "product_search", phx_target: @myself], fn f -> %>

              <%= text_input f, :product_name, placeholder: "Search Orders", class: "form-control" %>
            <% end %>
          </div>
        </div>

        <div class="col-4 col-md-2 col-xl-1 ps-md-0 text-end">
        <div class="dropdown">
            <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <svg class="icon icon-sm" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path></svg>
                <span class="visually-hidden">Toggle Dropdown</span>
            </button>
            <div class="dropdown-menu dropdown-menu-xs dropdown-menu-end pb-0" style="">
                <span class="small ps-3 fw-bold text-dark">Show</span>
                <button class="dropdown-item fw-bold"type="button" phx-value-status="initated" phx-click="filter_status">Initiated</button>
                <button class="dropdown-item fw-bold"type="button" phx-value-status="confirmed" phx-click="filter_status">Confirmed</button>
                <button class="dropdown-item fw-bold"type="button" phx-value-status="picked"phx-click="filter_status">Picked</button>
                <button class="dropdown-item fw-bold"type="button" phx-value-status="done"phx-click="filter_status">Done</button>

            </div>
        </div>
    </div>
    </div>

    <div class="card border-0 shadow mb-4">
    <div class="card-body">
    <div class="table-responsive">



    <table class="table table-centered table-nowrap mb-0 rounded">
    <thead class="thead-light">
    <tr>
    <th class="border-0 rounded-start">#</th>
    <th class="border-0">Product Name</th>
    <th class="border-0">Quantity</th>
    <th class="border-0">Status</th>
    <th class="border-0">Ordered on</th>
    </tr>
    </thead>
    <tbody>

    <%= if Enum.count(@orders) >0 do%>

    <%= for {order, _index} <- Enum.with_index(@orders_for_page, 1) do%>
    <tr phx-click="order">
    <td>

    <%= link order.id, to: Routes.supplier_path(@socket, :show_order_details, order.id) %>

    </td>
    <td><%= order.product.name %></td>
    <td><%= order.quantity %></td>
    <td><%= order.status %></td>
    <td><%= Date.to_string(order.inserted_at) %></td>
    </tr>
    <% end %>

    <div class="card-footer px-3 border-0 d-flex flex-column flex-lg-row align-items-center justify-content-between">
    <nav aria-label="Page navigation example">
        <ul class="pagination mb-0">

          <%= unless @page_number == 0 do %>
              <li class="page-item">
                          <span class="page-link" phx-click="previous">Previous</span>
                      </li>

          <% end %>




        <%= for {_page, index} <- Enum.with_index(@paginated_orders) do%>

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
            <div class="fw-normal small mt-4 mt-lg-0">Showing <b><%= @page_entries%></b> out of <b><%= @total_entries %></b> entries</div>
        </div>


    <% else %>

    <tr>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
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
