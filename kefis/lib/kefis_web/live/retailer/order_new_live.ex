defmodule KefisWeb.Retailer.OrderNewLive do
  use KefisWeb, :live_component

  alias Kefis.Products
  alias Kefis.Chain.OrderDetail
  alias Kefis.Orders
  alias Ecto.Changeset
  alias Kefis.Repo

  def update(%{details: %{live_action: live_action}} = _dsds, socket) do
    {:ok,
     socket
     |> assign(:total, 0)
     |> assign(:finished_selection, false)
     |> assign(:selected_products, [])
     |> assign(:selected_products_id, [])
     |> assign(:live_action, live_action)
     |> init_items()}
  end

  def handle_event("search", %{"product_name" => search}, socket) do
    items = Products.search_product(search)
    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    {:noreply,
     socket
     |> assign(:items, items)
     |> assign(:total_pages, total_pages)
     |> assign(:total_entries, total_entries)
     |> assign(:page_number, 0)
     |> assign(:page_size, 0)
     |> assign(:current_page, 0)
     |> assign(:paginated_items, paginated_items)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
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
            <li class="breadcrumb-item active" aria-current="page">New Order</li>
          </ol>
        </nav>
        <h2 class="h4"></h2>
        <p class="mb-0"> Request for items for your shop </p>
      </div>
    </div>
    <div class="py-4">

    <button type="button" phx-click="toggle_finished" phx-target={@myself} class="btn btn-gray-800 d-inline-flex align-items-center me-2">View Cart</button>

    </div>

    <div class="card border-0 shadow mb-4">
    <div class="card-body">

    <%= if @finished_selection do %>

      

      <%= live_component KefisWeb.Retailer.CartLive,
        id: "order.id",
        selected_products: @selected_products,
        total: @total
      %>

    <% else %>
      <form class="navbar-search form-inline" id="navbar-search-main" phx-change="search" phx-target={@myself}>
        <div class="input-group input-group-merge search-bar">
            <span class="input-group-text" id="topbar-addon">
                <svg class="icon icon-xs" x-description="Heroicon name: solid/search"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor"
                    aria-hidden="true">
                    <path fill-rule="evenodd"
                        d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                        clip-rule="evenodd"></path>
                </svg>
            </span>
            <input name="product_name" type="text" class="form-control" id="topbarInputIconLeft" placeholder="Which product are you looking for?"
                    aria-label="Search" aria-describedby="topbar-addon">
        </div>
      </form>

      <%= if @total_entries > 0 do%>

        <div class="table-responsive">
          <table class="table table-centered table-nowrap mb-0 rounded">
            <thead class="thead-light">
              <tr>
                <th class="border-0">Name</th>
                <th class="border-0">Price</th>
                <th class="border-0">Quantity</th>
                <th class="border-0">Action</th>
              </tr>
            </thead>
            <tbody>

            <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
              <tr>
                <td><%= item.name %></td>
                <td><%= item.price %></td>
                <td><%= item.sku %></td>
                <td><button class="btn btn-gray-500" phx-click="product_click" value={"#{item.id}"} phx-target={@myself}>Add</button></td>
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

          <div class="fw-normal small mt-4 mt-lg-0">Showing <b><%= @page_entries%></b> out of <b><%= @total_entries %></b> entries</div>
          </div>

        </div>

      <% else %>
        <div class="col-md-6">
          <div class="mt-5 mb-3 mt-sm-0">
              <span class="h6 fw-bold">No Record Found</span>
          </div>
          <p class="lead">We could not find the product you were looking for.</p>
        </div>
      <% end %>
    <% end %>





      </div>


    </div>
    </div>

    """
  end

  defp init_items(socket) do
    items = Products.list_products()

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
  def handle_event("type_search", %{"search" => %{"product_name" => search}}, socket) do
    items = Products.search_product(search)
    {:noreply, assign(socket, :items, items)}
  end

  @impl true
  def handle_event(
        "product_click",
        %{"value" => value},
        %{assigns: %{selected_products: selected_products, total: total}} = socket
      ) do
    product_details = Products.find(value)

    new_total = 1 * product_details.price + total
    order_detail = %{status: "initiated", quantity: 1, price: product_details.price}

    order_detail_changeset =
      OrderDetail.changeset(%OrderDetail{}, order_detail)
      |> Changeset.put_assoc(:product, product_details)
      |> Changeset.put_assoc(:partner, product_details.partner)

    # Add Product IDS to the list
    selected_products = Enum.uniq(List.insert_at(selected_products, -1, order_detail_changeset))

    {:noreply,
     socket
     |> assign(:selected_products, selected_products)
     |> assign(:total, new_total)}
  end

  @impl true
  def handle_event(
        "toggle_finished",
        _value,
        %{assigns: %{finished_selection: finished_selection}} = socket
      ) do
    {:noreply, assign(socket, :finished_selection, !finished_selection)}
  end
end
