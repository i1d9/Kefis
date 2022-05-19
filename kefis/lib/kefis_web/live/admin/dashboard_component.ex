defmodule KefisWeb.Admin.DashboardComponent do
  use KefisWeb, :live_component

  alias Kefis.Partners
  alias Kefis.Users
  alias Kefis.Transactions
  alias Kefis.Orders

  def update(_assigns, socket) do
    {:ok,
     socket
     |> init()}
  end

  defp init(socket) do
    retailers = Partners.partners_type("retailer")
    suppliers = Partners.partners_type("supplier")
    orders = Orders.admin_list_orders()
    users = Users.list() |> Enum.slice(0..5)
    transactions = Transactions.list_transactions() |> Enum.slice(0..5)
    no_of_suppliers = Enum.count(suppliers)
    no_of_orders = Enum.count(orders)
    no_of_retailers = Enum.count(retailers)

    socket
    |> assign(:no_of_retailers, no_of_retailers)
    |> assign(:no_of_orders, no_of_orders)
    |> assign(:no_of_suppliers, no_of_suppliers)
    |> assign(:users, users)
    |> assign(:transactions, transactions)
  end

  def render(assigns) do
    ~H"""
    <div>

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


    <div class="py-4">

        <div class="dropdown">
            <button class="btn btn-gray-800 d-inline-flex align-items-center me-2 dropdown-toggle"
                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <svg class="icon icon-xs me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                </svg>
                New
            </button>
            <div class="dropdown-menu dashboard-dropdown dropdown-menu-start mt-2 py-1">


                <%= link "Add Partner", to: Routes.live_path(@socket, KefisWeb.Admin.Partner.NewLive), class: "dropdown-item d-flex align-items-center" %>


                <a class="dropdown-item d-flex align-items-center" href="#">

                                        Add User
                </a>


            </div>
        </div>
    </div>

    <div class="row">



        <div class="col-12 col-sm-6 col-xl-4 mb-4">
        <div class="card border-0 shadow">
            <div class="card-body">
                <div class="row d-block d-xl-flex align-items-center">
                    <div
                        class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                        <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">
                            <svg class="icon" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z">
                                </path>
                            </svg>
                        </div>
                        <div class="d-sm-none">
                            <h2 class="h5">

                            <%= link "Suppliers", to: Routes.index_path(@socket, :supplier), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>

                            </h2>

                            <h3 class="fw-extrabold mb-1">3</h3>
                        </div>
                    </div>
                    <div class="col-12 col-xl-7 px-xl-0">
                        <div class="d-none d-sm-block">



                            <%= link "Suppliers", to: Routes.index_path(@socket, :supplier), class: "h6 text-gray-400 mb-0" %>

                            <h3 class="fw-extrabold mb-2"><%= @no_of_suppliers %></h3>
                        </div>
                        <small class="d-flex align-items-center text-gray-500">

                        </small>

                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="col-12 col-sm-6 col-xl-4 mb-4">
        <div class="card border-0 shadow">
            <div class="card-body">
                <div class="row d-block d-xl-flex align-items-center">
                    <div
                        class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                        <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">
                            <svg class="icon" fill="currentColor" viewBox="0 0 20 20"
                                xmlns="http://www.w3.org/2000/svg">
                                <path
                                    d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z">
                                </path>
                            </svg>
                        </div>
                        <div class="d-sm-none">
                            <h2 class="h5">

                            <%= link "Retailer", to: Routes.index_path(@socket, :retailer), class: "h6 text-gray-400 mb-0" %>


                            </h2>

                            <h3 class="fw-extrabold mb-1">3</h3>
                        </div>
                    </div>
                    <div class="col-12 col-xl-7 px-xl-0">
                        <div class="d-none d-sm-block">
                        <%= link "Retailer", to: Routes.index_path(@socket, :retailer), class: "h6 text-gray-400 mb-0" %>



                            <h3 class="fw-extrabold mb-2"><%= @no_of_retailers %></h3>
                        </div>
                        <small class="d-flex align-items-center text-gray-500">

                        </small>

                    </div>
                </div>
            </div>
        </div>
    </div>



        <div class="col-12 col-sm-6 col-xl-4 mb-4">
            <div class="card border-0 shadow">
                <div class="card-body">
                    <div class="row d-block d-xl-flex align-items-center">
                        <div
                            class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                            <div class="icon-shape icon-shape-secondary rounded me-4 me-sm-0">
                                <svg class="icon" fill="currentColor" viewBox="0 0 20 20"
                                    xmlns="http://www.w3.org/2000/svg">
                                    <path fill-rule="evenodd"
                                        d="M10 2a4 4 0 00-4 4v1H5a1 1 0 00-.994.89l-1 9A1 1 0 004 18h12a1 1 0 00.994-1.11l-1-9A1 1 0 0015 7h-1V6a4 4 0 00-4-4zm2 5V6a2 2 0 10-4 0v1h4zm-6 3a1 1 0 112 0 1 1 0 01-2 0zm7-1a1 1 0 100 2 1 1 0 000-2z"
                                        clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <div class="d-sm-none">
                                <h2 class="fw-extrabold h5">Revenue</h2>
                                <h3 class="mb-1">KES0</h3>
                            </div>
                        </div>
                        <div class="col-12 col-xl-7 px-xl-0">
                            <div class="d-none d-sm-block">
                                <h2 class="h6 text-gray-400 mb-0">Revenue</h2>
                                <h3 class="fw-extrabold mb-2">KES0</h3>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <div class="row">
        <div class="col-12 col-xl-8">
            <div class="row">
                <div class="col-12 mb-4">
                    <div class="card border-0 shadow">
                        <div class="card-header">
                            <div class="row align-items-center">
                                <div class="col">
                                    <h2 class="fs-5 fw-bold mb-0">Recent Transactions</h2>
                                </div>
                                <div class="col text-end">
                                    <%= link "See all", to: Routes.index_path(@socket, :transaction_index) , class: "btn btn-sm btn-primary" %>

                                </div>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table class="table align-items-center table-flush">
                                <thead class="thead-light">
                                    <tr>
                                        <th class="border-bottom" scope="col">Partner</th>
                                        <th class="border-bottom" scope="col">Type</th>
                                        <th class="border-bottom" scope="col">Value</th>

                                    </tr>
                                </thead>
                                <tbody>

                                <%= for transaction <- @transactions do %>
                                <tr>
                                <td>
                                <%= transaction.account.partner.name %>
                                </td>

                                <td>
                                <%= transaction.type %>
                                </td>


                                <td>
                                <%= transaction.amount %>
                                </td>




                                    </tr>
                                <% end %>





                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-12  mb-4">
                    <div class="card border-0 shadow">
                        <div class="card-header border-bottom d-flex align-items-center justify-content-between">
                            <h2 class="fs-5 fw-bold mb-0">Users</h2>
                            <%= link "See all", to: Routes.live_path(@socket, KefisWeb.Admin.User.IndexLive) , class: "btn btn-sm btn-primary" %>

                        </div>
                        <div class="card-body">
                            <ul class="list-group list-group-flush list my--3">

                              <%= for user <- @users do%>

                                <li class="list-group-item px-0">
                                    <div class="row align-items-center">


                                        <div class="col-auto ms--2">
                                            <h4 class="h6 mb-0">

                                                <a href="#"><%= user.first_name %> <%= user.second_name %></a>
                                            </h4>

                                        </div>
                                        <div class="col text-end">
                                            <a href="#"
                                                class="btn btn-sm btn-secondary d-inline-flex align-items-center">

                                                View
                                            </a>
                                        </div>
                                    </div>
                                </li>

                                <% end %>






                            </ul>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <div class="col-12 col-xl-4">
            <div class="col-12 px-0 mb-4">
                <div class="card border-0 shadow">
                    <div class="card-header d-flex flex-row align-items-center flex-0 border-bottom">
                        <div class="d-block">
                            <div class="h6 fw-normal text-gray mb-2">Total orders</div>
                            <h2 class="h3 fw-extrabold"><%= @no_of_orders %></h2>
                            <div class="small mt-2">

                            </div>
                        </div>

                    </div>
                    <div class="card-body p-2">
                        <div class="ct-chart-ranking ct-golden-section ct-series-a">
                        <%= live_component @socket, KefisWeb.Admin.Order.SalesPredicted %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 px-0 mb-4">
                <div class="card border-0 shadow">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between border-bottom pb-3">
                            <div>
                                <div class="h6 mb-0 d-flex align-items-center">
                                    <svg class="icon icon-xs text-gray-500 me-2" fill="currentColor" viewBox="0 0 20 20"
                                        xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd"
                                            d="M10 18a8 8 0 100-16 8 8 0 000 16zM4.332 8.027a6.012 6.012 0 011.912-2.706C6.512 5.73 6.974 6 7.5 6A1.5 1.5 0 019 7.5V8a2 2 0 004 0 2 2 0 011.523-1.943A5.977 5.977 0 0116 10c0 .34-.028.675-.083 1H15a2 2 0 00-2 2v2.197A5.973 5.973 0 0110 16v-2a2 2 0 00-2-2 2 2 0 01-2-2 2 2 0 00-1.668-1.973z"
                                            clip-rule="evenodd"></path>
                                    </svg>
                                    Top Partners
                                </div>
                            </div>
                            <div>

                            </div>
                        </div>

                        <div class="d-flex align-items-center justify-content-between pt-3">
                            <div>
                                <div class="h6 mb-0 d-flex align-items-center">
                                    1.

                                </div>

                            </div>

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
