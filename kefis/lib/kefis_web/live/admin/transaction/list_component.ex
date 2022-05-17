defmodule KefisWeb.Admin.Transaction.ListComponent do
  use KefisWeb, :live_component

  alias Kefis.Transactions

  def update(_assigns, socket) do
    {:ok,
    socket
    |> init_items()
    }
  end

  defp init_items(socket) do

    items = Transactions.list_transactions()

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
    <div class="table-settings mb-4">
      <div class="card border-0 shadow mb-4">
        <div class="card-body">
          <div class="table-responsive">
            <table class="table table-centered table-nowrap mb-0 rounded">
              <thead class="thead-light">
              <tr>
                <th class="border-0 rounded-start">#</th>
                <th class="border-0">Amount</th>


                <th class="border-0">Status</th>

                <th class="border-0">Actions</th>
              </tr>
              </thead>
              <tbody>
                <%= for {item, index} <- Enum.with_index(@items_for_page, 1) do%>

                <tr>
                  <td><%= index %></td>
                  <td><%= item.amount %></td>
                  <td><%= item.status %></td>
                  <td>

                  </td>
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