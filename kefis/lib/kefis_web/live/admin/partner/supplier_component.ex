defmodule KefisWeb.Admin.Partner.SupplierComponent do
  use KefisWeb, :live_component

  alias Kefis.Partners

  def update(_assigns, socket) do
    {:ok,
     socket
     |> init_items()}
  end

  defp init_items(socket) do
    items = Partners.partners_type("supplier")

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
      <div class="table-settings mb-4">
      <div class="row align-items-center justify-content-between">
          <div class="col col-md-6 col-lg-3 col-xl-4">
              <div class="input-group me-2 me-lg-3 fmxw-400">
                  <span class="input-group-text">
                      <svg class="icon icon-xs" x-description="Heroicon name: solid/search" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                          <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                      </svg>
                  </span>
                  <input type="text" class="form-control" placeholder="Search Supplier">
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
      </div>

    <div class="card border-0 shadow mb-4">
    <div class="card-body">


          <table class="table table-centered table-nowrap mb-0 rounded">
          <thead class="thead-light">
          <tr>
          <th class="border-0 rounded-start">#</th>
          <th class="border-0">Name</th>
          <th class="border-0">Phone</th>
              <th class="border-0">Email</th>
              <th class="border-0">Location</th>


          </tr>
          </thead>
          <tbody>
          <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
          <tr>
            <td><%= index %></td>
            <td><%= item.name %></td>
            <td><%= item.phone %></td>
            <td><%= item.contact_email %></td>
            <td><%= item.location %></td>
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
    </div></div>
    </div>
    """
  end

  def handle_event(
        "change_page",
        %{"index" => index} = _params,
        %{assigns: %{paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(String.to_integer(index))
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, String.to_integer(index))
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{assigns: %{page_number: page_number, paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(page_number + 1)
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number + 1)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{assigns: %{page_number: page_number, paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(page_number - 1)
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number - 1)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end
end
