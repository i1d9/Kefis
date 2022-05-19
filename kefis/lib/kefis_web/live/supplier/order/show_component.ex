defmodule KefisWeb.Supplier.Order.ShowComponent do
  use KefisWeb, :live_component
  alias Kefis.Orders

  def update(%{details: assigns}, socket) do
    IO.inspect(assigns)

    {:ok,
     socket
     |> assign(assigns)}
  end

  def render(assigns) do
    ~H"""
    <div>


      <div class="card border-0 shadow mb-4">
          <div class="card-body">


      <h1><%= @order.order.partner.name %></h1>
      <h1><%= @order.order.partner.email %></h1>
      <h1><%= @order.order.partner.phone %></h1>
      <p>
      <%= @order.product.name %>
      </p>
      <p>
      <%= @order.quantity %>
      </p>

      <p>
      <%= @order.status %>
      </p>

      <p>KES
      <%= @order.price %>
      </p>

      <%= if @order.status == "initiated" do%>


      <div class="mb-3">
      <form phx-submit="change_order_detail_status" phx-target={@myself}>
      <label for="status">Status</label>
      <select name="status" id="status" class="form-select">
      <option value="confirmed">Confirmed</option>
      <option value="cancelled">Cancelled</option>
      </select>
      <button type="submit" class="btn btn-success">Save</button>
      </form>
      </div>


      <% end %>

          </div></div>
    </div>
    """
  end

  def handle_event(
        "change_order_detail_status",
        %{"status" => status} = _value,
        %{assigns: %{order: order}} = socket
      ) do
    case Orders.update_order_detail(order, %{status: status}) do
      {:ok, order} ->
        IO.inspect(order)

        {:noreply,
         socket
         |> assign(:order, order)}

      {:error, error} ->
        IO.inspect(error)
        {:noreply, socket}
    end
  end
end
