defmodule KefisWeb.Retailer.NewOrderLive do

  use KefisWeb, :live_view

  alias Kefis.Products
  import Ecto.Changeset
  alias Kefis.Chain.OrderDetail
  alias Kefis.Chain.Order
  alias Ecto.Changeset
  alias Kefis.Repo
  alias Kefis.Chain.Partner

  @impl true
  def mount(_params, _session, socket) do
    products = Products.list_products()

    {:ok,
    socket
    |> assign(:total, 0)
    |> assign(:finished_selection, false)
    |> assign(:selected_products, [])
    |> assign(:products, products)}
  end

  @impl true
  def handle_event("type_search", %{"search" => %{"product_name" => search}}, socket) do

    products = Products.search_product(search)
    {:noreply, assign(socket, :products, products)}
  end

  @impl true
  def handle_event("toggle_finished", _value, %{assigns: %{finished_selection: finished_selection, }} = socket) do
    {:noreply, assign(socket, :finished_selection, !finished_selection) }
  end

  @impl true
  def handle_event("product_click", %{"value" => value}, %{assigns: %{selected_products: selected_products, total: total}} = socket) do


    product_details = Products.find(value)


    new_total = 1 * product_details.price + total
    order_detail = %{status: "initiated", quantity: 1, price: product_details.price}
    order_detail_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail)
    |> Changeset.put_assoc(:product, product_details)
    |> Changeset.put_assoc(:partner, product_details.partner)

    #Add Product IDS to the list
    selected_products = List.insert_at(selected_products, -1, order_detail_changeset)


    {:noreply,
    socket
    |> assign(:selected_products, selected_products)
    |> assign(:total, new_total)
    }

  end


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

  def handle_event("submit_order", _value, %{assigns: %{selected_products: selected_product_changesets, total: total}} = socket) do
    retailer = Repo.get(Partner, 1)
    order_info = %{value: total, status: "Initiatied"}
    order = Order.changeset(%Order{}, order_info)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:order_details, selected_product_changesets)
      |> Ecto.Changeset.put_assoc(:partner, retailer)
      |> Repo.insert()

    IO.inspect(order)
    {:noreply,
    socket
    |> assign(:selected_products, selected_product_changesets)
    }
  end

end
