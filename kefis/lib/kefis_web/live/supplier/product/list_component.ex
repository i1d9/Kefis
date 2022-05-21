defmodule KefisWeb.Supplier.Product.ListComponent do
  use KefisWeb, :live_component

  alias Kefis.Repo
  alias Kefis.Products
  alias Kefis.Chain
  alias Kefis.Chain.Product

  def update(%{details: detailis}, socket) do
    IO.inspect(detailis)

    {:ok,
     socket
     |> assign(detailis)
     |> init_item()}
  end

  def init_item(socket) do
    partner = Repo.preload(socket.assigns.supplier, :products)

    IO.inspect(partner.products)

    products = partner.products

    page_entries = 10
    paginated_products = products |> Enum.chunk_every(page_entries)
    products_for_page = paginated_products |> Enum.at(0)
    total_entries = products |> Enum.count()
    total_pages = paginated_products |> Enum.count()

    socket
    |> assign(:products, products)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_products, paginated_products)
    |> assign(:products_for_page, products_for_page)
    |> assign(:page_entries, page_entries)
  end

  def handle_event("product_search", %{"search" => %{"product_name" => product}} = _value, socket) do
    products = Products.search_product(product)
    page_entries = 10
    paginated_products = products |> Enum.chunk_every(page_entries)
    products_for_page = paginated_products |> Enum.at(0)
    total_entries = products |> Enum.count()
    total_pages = paginated_products |> Enum.count()

    {:noreply,
     socket
     |> assign(:products, products)
     |> assign(:total_pages, total_pages)
     |> assign(:total_entries, total_entries)
     |> assign(:page_number, 0)
     |> assign(:page_size, 0)
     |> assign(:current_page, 0)
     |> assign(:paginated_products, paginated_products)
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def render(assigns) do
    ~H"""
    <div class="table-settings mb-4">


        <div class="row align-items-center justify-content-between">

        <div class="col col-md-6 col-lg-3 col-xl-4">
          <div class="input-group me-2 me-lg-3 fmxw-400">
            <%= form_for :search, "#", [phx_change: "product_search", phx_target: @myself], fn f -> %>

              <%= text_input f, :product_name, placeholder: "Search Products", class: "form-control" %>
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
                    <a class="dropdown-item d-flex align-items-center fw-bold" href="#">10 <svg class="icon icon-xxs ms-auto" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg></a>
                    <a class="dropdown-item fw-bold" href="#">20</a>
                    <a class="dropdown-item fw-bold rounded-bottom" href="#">30</a>
                </div>
            </div>
        </div>
    </div>




    <div class="card border-0 shadow mb-4">
    <div class="card-body">

    <div class="py-4">
    <%= link "New Product", to: Routes.index_path(@socket, :new_product),  class: "btn btn-gray-800 d-inline-flex align-items-center me-2 dropdown-toggle" %>
    </div>

        <div class="table-responsive">
        <%= if Enum.count(@products) > 0 do%>



          <table class="table table-centered table-nowrap mb-0 rounded">
          <thead class="thead-light">
          <tr>
          <th class="border-0 rounded-start">#</th>
          <th class="border-0">Name</th>

          <th class="border-0">Price</th>

          <th class="border-0">Actions</th>
          </tr>
          </thead>
          <tbody>
          <%= for {product, index} <- Enum.with_index(@products_for_page, 1) do%>
          <tr phx-click="order">
          <td><%= index %></td>
          <td>
          <span class="avatar">
            <img
                alt={product.name}

                class="rounded"
                src={Routes.static_path(@socket, product.image)} >
          </span>
          <%= product.name %></td>
          <td><%= product.price %></td>

          <td>

          <%= link "Edit", to: Routes.index_path(@socket, :edit_product, product.id), class: "btn btn-gray-200"%>

          <button class="btn btn-danger" phx-value-id={product.id} phx-target={@myself} phx-click="delete_product">Delete</button>
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
                                          <span class="page-link" phx-click="previous"phx-target={@myself}>Previous</span>
                                      </li>

          <% end %>




                <%= for {_page, index} <- Enum.with_index(@paginated_products) do%>

                      <%= if @page_number == index do%>
                          <li class="page-item active">
                              <span class="page-link" ><%= index + 1%></span>
                          </li>
                      <% else %>

                      <li class="page-item">
                          <span class="page-link" phx-click="change_page" phx-value-index={index} phx-target={@myself}><%= index + 1%></span>
                      </li>
                      <% end %>
                <% end %>



          <%= unless @page_number == @total_pages - 1 do %>
                              <li class="page-item">
                                          <span class="page-link" phx-click="next" phx-target={@myself}>Next</span>
                                      </li>

          <% end %>
                                  </ul>
                              </nav>
                              <div class="fw-normal small mt-4 mt-lg-0">Showing <b>  <%= if @page_entries < 10, do: @page_entries, else: @total_entries %></b> out of <b><%= @total_entries %></b> entries</div>

                              </div>

                          <% else %>
          <h1>You don't have any products</h1>
          <% end %>
    </div>
    </div>
    </div>
    </div>
    """
  end

  def handle_event(
        "change_page",
        %{"index" => index} = _params,
        %{assigns: %{paginated_products: paginated_products}} = socket
      ) do
    products_for_page = paginated_products |> Enum.at(String.to_integer(index))
    page_entries = products_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, String.to_integer(index))
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{assigns: %{page_number: page_number, paginated_products: paginated_products}} = socket
      ) do
    products_for_page = paginated_products |> Enum.at(page_number + 1)
    page_entries = products_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number + 1)
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{assigns: %{page_number: page_number, paginated_products: paginated_products}} = socket
      ) do
    products_for_page = paginated_products |> Enum.at(page_number - 1)
    page_entries = products_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number - 1)
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event("delete_product", %{"id" => id}, socket) do
    # Products.delete()

    case Products.delete(String.to_integer(id)) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> init_item()}

      {:error, _error} ->
        {:noreply, socket}
    end
  end

  def handle_event("edit_product", _value, socket) do
    {:noreply, socket}
  end
end
