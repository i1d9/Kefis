defmodule KefisWeb.Retailer.DashboardLive do
  use KefisWeb, :live_component
  alias Kefis.Orders
  alias Kefis.Accounts

  def update(%{details: assigns}, socket) do
    IO.inspect(assigns)

    {:ok,
     socket
     |> assign(assigns)
     |> init_items()}
  end

  def init_items(socket) do
    socket
    |> assign(:orders, Orders.retailer_orders(socket.assigns.user))
    |> assign(:account, Accounts.get_account(socket.assigns.user.partner))
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="py-4">

    </div>
    <div class="row">

      <div class="col-12 col-sm-6 col-xl-6 mb-4">
        <div class="card border-0 shadow">
          <div class="card-body">
            <div class="row d-block d-xl-flex align-items-center">
              <div
                class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">

                <i class="fa fa-shopping-basket" aria-hidden="true"></i>

                </div>
                <div class="d-sm-none">
                  <h2 class="h5">Orders</h2>
                  <h3 class="fw-extrabold mb-1"><%= Enum.count(@orders) %></h3>
                </div>
              </div>
              <div class="col-12 col-xl-7 px-xl-0">
                <div class="d-none d-sm-block">
                  <h2 class="h6 text-gray-400 mb-0">Orders</h2>

                  <h3 class="fw-extrabold mb-2"><%= Enum.count(@orders) %></h3>
                </div>


              </div>
            </div>
          </div>
        </div>
      </div>




      <div class="col-12 col-sm-6 col-xl-6 mb-4">
      <div class="card border-0 shadow">
        <div class="card-body">
          <div class="row d-block d-xl-flex align-items-center">
            <div
              class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
              <div class="icon-shape icon-shape-secondary rounded me-4 me-sm-0">
              <i class="fa-solid fa-sack-dollar"></i>
              </div>
              <div class="d-sm-none">
                <h2 class="fw-extrabold h5">Account Balance</h2>
                <h3 class="fw-extrabold mb-2">KES <%= @account.balance %></h3>

              </div>
            </div>
            <div class="col-12 col-xl-7 px-xl-0">
              <div class="d-none d-sm-block">
                <h2 class="h6 text-gray-400 mb-0">Account Balance</h2>


                <h3 class="fw-extrabold mb-2">KES <%= @account.balance %></h3>

              </div>


            </div>
          </div>
        </div>
      </div>
    </div>


    </div>
    <div class="row">
      <div class="col-12 col-xl-12">
        <div class="row">
          <div class="col-12 mb-4">
            <div class="card border-0 shadow">
              <div class="card-header">
                <div class="row align-items-center">
                  <div class="col">
                    <h2 class="fs-5 fw-bold mb-0">Recents</h2>
                  </div>
                  <div class="col text-end">

                  
                    <%= link  to: Routes.orders_path(@socket, :index), class: "nav-link" do%>
                    <span class="btn btn-sm btn-primary">See all</span>
                    <% end%>
                  </div>
                </div>
              </div>
              <div class="table-responsive">
                <table class="table align-items-center table-flush">
                  <thead class="thead-light">
                    <tr>
                      <th class="border-bottom" scope="col">Order ID</th>

                      <th class="border-bottom" scope="col">Total</th>
                      <th class="border-bottom" scope="col">Status</th>
                      <th class="border-bottom" scope="col">Date  </th>
                    </tr>
                  </thead>
                  <tbody>

                    <%= for order <- @orders do%>
                      <tr>
                        <td>
                          <%= order.id %>
                        </td>

                        <td>
                        <%= order.value %>
                        </td>
                        <td>
                        <%= order.status %>
                        </td>
                        <td>
                        <%= order.date %>
                        </td>
                      </tr>
                    <% end %>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
    </div>
    """
  end
end
