defmodule KefisWeb.Admin.Partner.DetailComponent do
  use KefisWeb, :live_component

  alias Kefis.Repo
  alias Kefis.Products

  def update(%{details: %{partner: partner} = details}, socket) do
    {:ok,
     socket
     |> assign(details)
     |> init_items(partner.type)}
  end

  def init_items(socket, "supplier") do
    partner_info =
      Repo.preload(socket.assigns.partner, [:products, :order_details, account: [:transactions]])

    IO.inspect(partner_info)

    socket
    |> assign(:products, partner_info.products)
    |> assign(:orders, partner_info.order_details)
    |> assign(:transactions, partner_info.account.transactions)
  end

  def partner_type(assigns, "supplier") do
    ~H"""
    <div>




        <div class="col-2 col-sm-3 col-xl-4 mb-4">

        <div class="card-body">
                <div class="row d-block d-xl-flex align-items-center">
                    <div
                        class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                        <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">
                        <span class="sidebar-icon">

                        <i class="fa-solid fa-cart-flatbed"></i>

                    </span>
                        </div>
                        <div class="d-sm-none">
                            <h2 class="h5">

                            <%= link "Products", to: Routes.index_path(@socket, :partner_products, @partner.id), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>

                            </h2>

                            <h3 class="fw-extrabold mb-1"><%= Enum.count(@products) %></h3>
                        </div>
                    </div>
                    <div class="col-12 col-xl-7 px-xl-0">
                        <div class="d-none d-sm-block">



                            <%= link "Products", to: Routes.index_path(@socket, :partner_products, @partner.id), class: "h6 text-gray-400 mb-0" %>

                            <h3 class="fw-extrabold mb-2"><%= Enum.count(@products) %></h3>
                        </div>
                        <small class="d-flex align-items-center text-gray-500">

                        </small>

                    </div>
                </div>
        </div>

        </div>

        <div class="col-2 col-sm-3 col-xl-4 mb-4">

        <div class="card-body">
                <div class="row d-block d-xl-flex align-items-center">
                    <div
                        class="col-4 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                        <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">
                        <span class="sidebar-icon">


                        <i class="fa-solid fa-sack-dollar"></i>
                    </span>
                        </div>
                        <div class="d-sm-none">
                            <h2 class="h5">

                            <%= link "Transactions", to: Routes.index_path(@socket, :partner_transactions,  @partner.id), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>

                            </h2>

                            <h3 class="fw-extrabold mb-1"><%= Enum.count(@transactions) %></h3>
                        </div>
                    </div>
                    <div class="col-4 col-xl-7 px-xl-0">
                        <div class="d-none d-sm-block">



                            <%= link "Transactions", to: Routes.index_path(@socket, :partner_transactions, @partner.id ), class: "h6 text-gray-400 mb-0" %>

                            <h3 class="fw-extrabold mb-2"><%= Enum.count(@transactions) %></h3>
                        </div>
                        <small class="d-flex align-items-center text-gray-500">

                        </small>

                    </div>
                </div>
        </div>

        </div>


        <div class="col-2 col-sm-3 col-xl-4 mb-4">

        <div class="card-body">
                <div class="row d-block d-xl-flex align-items-center">
                    <div
                        class="col-4 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                        <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">
                        <span class="sidebar-icon">

                        <i class="fa-solid fa-store"></i>

                    </span>
                        </div>

                        <div class="d-sm-none">
                            <h2 class="h5">

                            <%= link "Orders", to: Routes.index_path(@socket, :partner_order, @partner.id), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>

                            </h2>

                            <h3 class="fw-extrabold mb-1"><%= Enum.count(@orders) %></h3>
                        </div>
                    </div>
                    <div class="col-4 col-xl-7 px-xl-0">
                        <div class="d-none d-sm-block">



                            <%= link "Orders", to: Routes.index_path(@socket, :partner_order, @partner.id), class: "h6 text-gray-400 mb-0" %>

                            <h3 class="fw-extrabold mb-2"><%= Enum.count(@orders) %></h3>
                        </div>
                        <small class="d-flex align-items-center text-gray-500">

                        </small>

                    </div>
                </div>
        </div>

        </div>

    </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div class="card border-0 shadow">
    <div class="card-body">
      <h1><%= @partner.name %></h1>
      <span><%= @partner.email %></span>
      <span><%= @partner.phone %></span>
      <div>
        <%= link to: Routes.index_path(@socket, :edit_partner, @partner.id), class: "btn btn-gray-200" do%>
        <span>

                                <span class="sidebar-text">Edit</span>
                            </span>
        <% end %>




        <button type="button" class="btn btn-danger">
        Delete
        </button>




      </div>
      <div>
        <%= partner_type(assigns, @partner.type)  %>
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
     |> assign(:product_page_number, String.to_integer(index))
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{
          assigns: %{
            product_page_number: product_page_number,
            paginated_products: paginated_products
          }
        } = socket
      ) do
    products_for_page = paginated_products |> Enum.at(product_page_number + 1)
    page_entries = products_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:product_page_number, product_page_number + 1)
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{
          assigns: %{
            product_page_number: product_page_number,
            paginated_products: paginated_products
          }
        } = socket
      ) do
    products_for_page = paginated_products |> Enum.at(product_page_number - 1)
    page_entries = products_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:product_page_number, product_page_number - 1)
     |> assign(:products_for_page, products_for_page)
     |> assign(:page_entries, page_entries)}
  end
end
