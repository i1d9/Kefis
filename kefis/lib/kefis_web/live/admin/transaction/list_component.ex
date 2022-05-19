defmodule KefisWeb.Admin.Transaction.ListComponent do
  use KefisWeb, :live_component

  alias Kefis.Transactions

  def update(_assigns, socket) do
    {:ok,
     socket
     |> init_items()}
  end

  defp init_items(socket) do
    items = Transactions.list_transactions()

    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    IO.inspect(items)

    socket
    |> assign(:items, items)
    |> assign(:filter_type, 0)
    |> assign(:initial_items, items)
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
    <div class="table-settings mb-4">
      <div class="card border-0 shadow mb-4">
        <div class="card-body">
        <%= if @total_entries > 0 do%>
        <div class="table-responsive">
        <table class="table table-centered table-nowrap mb-0 rounded">
          <thead class="thead-light">
            <tr>
              <th class="border-0">

              </th>
              <th class="border-0">Partner</th>
              <th class="border-0">Amount</th>
              <th class="border-0">Status</th>
              <th class="border-0" phx-click="type_filter" phx-target={@myself} >Type</th>
              <th class="border-0">Date</th>
            </tr>
          </thead>
          <tbody>

          <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>
            <tr>
              <td>
              <%= link index, to: Routes.orders_path(@socket, :show_my_transaction, item.id)  %>
              </td>

              <td>
              <%= item.account.partner.name %>
              </td>

              <td>
              <%= item.amount %>
              </td>

              <td>
              <%= item.status %>
              </td>

              <td>
              <%= item.type %>
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
                <span class="page-link" phx-click="previous" phx-target={@myself}>Previous</span>
              </li>
            <% end %>




            <%= for {_page, index} <- Enum.with_index(@paginated_items) do%>
              <%= if @page_number == index do%>
                <li class="page-item active">
                <span class="page-link" ><%= index + 1%></span>
                </li>
              <% else %>
                <li class="page-item">
                <span class="page-link" phx-click="change_page" phx-target={@myself} phx-value-index={index} ><%= index + 1%></span>
                </li>
              <% end %>
            <% end %>



            <%= unless @page_number == @total_pages - 1 do %>
              <li class="page-item">
                        <span class="page-link" phx-target={@myself} phx-click="next">Next</span>
              </li>
            <% end %>
          </ul>
        </nav>

        <div class="fw-normal small mt-4 mt-lg-0">Showing <b><%= @page_entries%></b> out of <b><%= @total_entries %></b> entries</div>
        </div>

        </div>
        <% else %>

        <% end %>



        </div>
      </div>
    </div>
    """
  end

  def handle_event("type_filter", _value, socket) do
    items =
      case rem(socket.assigns.filter_type, 3) do
        0 ->
          socket.assigns.initial_items

        1 ->
          Enum.filter(socket.assigns.initial_items, fn item -> item.type == "deposit" end)

        2 ->
          Enum.filter(socket.assigns.initial_items, fn item -> item.type == "withdraw" end)
      end

    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    {:noreply,
     socket
     |> assign(:items, items)
     |> assign(:filter_type, socket.assigns.filter_type + 1)
     |> assign(:total_pages, total_pages)
     |> assign(:total_entries, total_entries)
     |> assign(:page_number, 0)
     |> assign(:page_size, 0)
     |> assign(:current_page, 0)
     |> assign(:paginated_items, paginated_items)
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

  @impl true
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
end
