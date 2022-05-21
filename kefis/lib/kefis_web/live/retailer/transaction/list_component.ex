defmodule KefisWeb.Retailer.Transaction.ListComponent do
  use KefisWeb, :live_component

  alias Kefis.Repo

  def update(%{details: %{user: user}} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> init_items(user)}
  end

  defp init_items(socket, user) do
    user = user |> Repo.preload(partner: [account: [:transactions]])

    items = user.partner.account.transactions

    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    socket
    |> assign(:items, items)
    |> assign(:filter_type, 0)
    |> assign(:initial_items, items)
    |> assign(:balance, user.partner.account.balance)
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


    <div class="py-4">


    <%= link "Deposit", to: Routes.orders_path(@socket, :transact, %{type: "deposit"}), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>

    <%= link "Withdraw", to: Routes.orders_path(@socket, :transact, %{type: "withdraw"}), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>

    </div>

    <div class="ps-md-0 text-end">
        <div class="dropdown">
            <button class="btn btn-link text-dark dropdown-toggle dropdown-toggle-split m-0 p-1" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <svg class="icon icon-sm" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z" clip-rule="evenodd"></path></svg>
                <span class="visually-hidden">Toggle Dropdown</span>
            </button>
            <div class="dropdown-menu dropdown-menu-xs dropdown-menu-end pb-0" style="">
                <span class="small ps-3 fw-bold text-dark">Show</span>
                <a class="dropdown-item d-flex align-items-center fw-bold" href="#">Today<svg class="icon icon-xxs ms-auto" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg></a>
                <a class="dropdown-item fw-bold" href="#">Yesterday</a>
                <a class="dropdown-item fw-bold rounded-bottom" href="#">Week</a>
                <a class="dropdown-item fw-bold rounded-bottom" href="#">Month</a>
                <a class="dropdown-item fw-bold rounded-bottom" href="#">Year</a>
            </div>
        </div>
    </div>


    <div class="card border-0 shadow mb-4">
    <div class="card-body">

    <h1>
    Available Balance: KES <%= @balance %>
    </h1>

    <%= if @total_entries > 0 do%>
    <div class="table-responsive">
    <table class="table table-centered table-nowrap mb-0 rounded">
      <thead class="thead-light">
        <tr>
          <th class="border-0">

          </th>
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
