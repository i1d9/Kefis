defmodule KefisWeb.Retailer.CartLive do
  use KefisWeb, :live_component

  alias Kefis.Products
  alias Kefis.Chain.OrderDetail
  alias Kefis.Orders
  alias Ecto.Changeset
  alias Kefis.Repo

  @impl true
  def update(%{selected_products: selected_products, total: total, user: user }= assig, socket) do
    IO.inspect(assig)

    {:ok,
    socket
    |> assign(selected_products: selected_products)
    |> assign(total: total)
    |> assign(user: user)

    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <%= unless @total == 0  do %>

        <div class="col-md-6">
          <div class="mt-5 mb-3 mt-sm-0">
            <span class="h6 fw-bold">KES <%= @total %> </span>
          </div>
          <p class="lead"></p>
        </div>

      <div class="mb-3">
      <button class="btn btn-success" phx-click="submit_order" phx-target={@myself}>Submit</button>
      </div>
      <% end %>

      <table class="table table-centered table-nowrap mb-0 rounded">
      <thead class="thead-light">
      <tr>
      <th class="border-0"></th>
      <th class="border-0">Name</th>
      <th class="border-0">Price</th>
      <th class="border-0">Quantity</th>
      <th class="border-0">Add</th>
      <th class="border-0">Sub</th>
      <th class="border-0">Delete</th>
      </tr>
      </thead>
      <tbody>

        <%= for {%{changes: selected_product} = _product, index} <- Enum.with_index(@selected_products) do %>
            <tr>
            <td>
            <img class="icon" src={Routes.static_path(@socket, selected_product.product.data.image)} />
          </td>
              <td><%= selected_product.product.data.name %></td>
              <td><%= selected_product.price %></td>
              <td><%= selected_product.quantity %></td>
              <td><button class="btn btn-success" phx-click="add" value={"#{index}"} phx-target={@myself}>Add</button></td>
              <td><button class="btn btn-warning" phx-click="sub" value={"#{index}"} phx-target={@myself}>Sub</button></td>
              <td><button class="btn btn-danger" phx-click="del" value={"#{index}"} phx-target={@myself}>Del</button></td>

            </tr>
          <% end %>
      </tbody>
      </table>
    </div>
    """
  end

  @impl true
  def handle_event("add", %{"value" => value}, %{assigns: %{selected_products: selected_products, total: total}} = socket) do
    {_status, product} = Enum.fetch(selected_products, String.to_integer(value))

    order_detail_changeset = Ecto.Changeset.update_change(product, :quantity, &(&1 + 1))
    new_selected_products = List.replace_at(selected_products,  String.to_integer(value), order_detail_changeset)

    new_total = total + order_detail_changeset.changes.price

    {:noreply,
      socket
      |> assign(:selected_products, new_selected_products)
      |> assign(:total, new_total)
    }
  end

  @impl true
  def handle_event("sub", %{"value" => value}, %{assigns: %{selected_products: selected_products, total: total}} = socket) do
    {_status, product} = Enum.fetch(selected_products, String.to_integer(value))

    if product.changes.quantity > 1 do
      order_detail_changeset = Ecto.Changeset.update_change(product, :quantity, &(&1 - 1))
      new_selected_products = List.replace_at(selected_products,  String.to_integer(value), order_detail_changeset)

      new_total = total - order_detail_changeset.changes.price
      {:noreply,
      socket
      |> assign(:selected_products, new_selected_products)
      |> assign(:total, new_total)
      }
    else
      {:noreply,
      socket
      |> assign(:selected_products, selected_products)
      }
    end

  end

  @impl true
  def handle_event("del", %{"value" => value}, %{assigns: %{selected_products: selected_products, total: total}} = socket) do
    #Remove item
    {removed_product, new_selected_products} = List.pop_at(selected_products, String.to_integer(value))
    new_total = total - (removed_product.changes.quantity * removed_product.changes.price)
    {:noreply,
    socket
    |> assign(:selected_products, new_selected_products)
    |> assign(:total, new_total)
    }
  end

  @impl true
  def handle_event("submit_order", _value, %{assigns: %{selected_products: selected_product_changesets, total: total, user: user}} = socket) do
    order_info = %{value: total, status: "Initiatied"}
    case Orders.retailer_new_order(order_info, user, selected_product_changesets) do
      {:ok, order} ->
        {:noreply,
        socket
        |> redirect(to: Routes.retailer_path(socket, :show_order, order.id))
        }
      {:error, _changeset} ->
        {:noreply,
        socket
        |> assign(:selected_products, selected_product_changesets)
        }
    end
  end

end
