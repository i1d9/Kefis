defmodule KefisWeb.Admin.Order.ShowLive do
  use KefisWeb, :live_component

  alias Kefis.Orders

  def update(%{details: %{live_action: live_action} = details} = _assigns, socket) do

    %{order_id: order_id, live_action: live_action, modal: modal} = details

    case live_action do
      :info ->
        %{detail: detail} = details

        {:ok,
         socket
         |> assign(:modal, modal)
         |> assign(:live_action, live_action)
         |> assign(:order_detail_id, detail)
         |> load_order(String.to_integer(order_id))}

      :detail ->
        {:ok,
         socket
         |> assign(:modal, modal)
         |> assign(:live_action, live_action)
         |> load_order(String.to_integer(order_id))}
    end
  end

  def handle_event("show_detail", %{"detail" => detail} = value, socket) do
    IO.inspect(value)

    {:noreply,
     socket
     |> assign(:order_detail_id, detail)
     |> assign(:modal, true)}
  end

  def render(assigns) do
    ~H"""


    <div>

    <%= if @live_action in [:info]  do %>



    <%= live_modal KefisWeb.Admin.Order.DetailComponent,
    id: @order_id,
    order_detail_id: @order_detail_id,
    action: @live_action,

    return_to: Routes.index_path(@socket, :detail, @order_id) %>


    <% end %>

    <div class="table-settings mb-4">
                <div class="row align-items-center justify-content-between">
                    <div class="col col-md-6 col-lg-3 col-xl-4">
                        <div class="input-group me-2 me-lg-3 fmxw-400">
                            <span class="input-group-text">
                                <svg class="icon icon-xs" x-description="Heroicon name: solid/search" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clip-rule="evenodd"></path>
                                </svg>
                            </span>
                            <input type="text" class="form-control" placeholder="Search Order">
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
                    <h1><%= @retailer.name %></h1>
                    <h1><%= @retailer.location %></h1>

                    <table class="table table-centered table-nowrap mb-0 rounded">
                    <thead class="thead-light">
                    <tr>
    <th class="border-0 rounded-start">#</th>
                  <th class="border-0">Product Name</th>
                  <th class="border-0">Price</th>
    <th class="border-0">Quantity</th>
    <th class="border-0">Status</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%= for {item, index} <- Enum.with_index(@order_details, 1) do%>
                        <tr>

                        <td>
                        <%= live_patch index, to: Routes.index_path(@socket, :info, @order.id, %{detail: item.id}) %>
                        </td>
                        <td><%= item.product.name %></td>
                                      <td><%= item.product.price %></td>

                                                              <td><%= item.quantity %></td>

                                                              <td><%= item.status %></td>

                        </tr>
                        <% end %>
                    </tbody>
                    </table>
                </div>
            </div>



    </div>
    """
  end

  defp load_order(socket, id) do
    order = Orders.get_order(id)
    order_details = order.order_details
    retailer = order.partner

    socket
    |> assign(:order, order)
    |> assign(:order_id, order.id)
    |> assign(:order_details, order_details)
    |> assign(:retailer, retailer)
  end

  defp apply_action(socket, :index, %{"id" => id}) do
    socket
    |> load_order(id)
  end

  defp apply_action(socket, :view_detail, %{"id" => id, "detail" => detail}) do
    IO.inspect(detail)

    socket
    |> load_order(id)
    |> assign(:order_detail_id, detail)
  end
end
