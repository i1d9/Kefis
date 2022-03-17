defmodule KefisWeb.Retailer.NewOrderLive do

  use KefisWeb, :live_view

  alias Kefis.Products
  import Ecto.Changeset
  alias Kefis.Chain.OrderDetail
  alias Kefis.Chain.Order
  alias Ecto.Changeset

  @impl true
  def mount(_params, _session, socket) do
    products = Products.list_products()


    {:ok,
    socket
    |> assign(:finished_selection, false)
    |> assign(:selected_products, [])
    |> assign(:products, products)}
  end

  @impl true
  def handle_event("type_search", %{"search" => %{"product_name" => search}}, socket) do
    IO.inspect(search)
    products = Products.search_product(search)
    {:noreply, assign(socket, :products, products)}
  end

  @impl true
  def handle_event("toggle_finished", _value, %{assigns: %{finished_selection: finished_selection, }} = socket) do
    {:noreply, assign(socket, :finished_selection, !finished_selection) }
  end

  @impl true
  def handle_event("product_click", %{"value" => value}, %{assigns: %{selected_products: selected_products, }} = socket) do

    IO.inspect(selected_products)
    product_details = Products.find(value)


    order_detail = %{
      status: "initiated",
      price: 10,
      quantity: 1,
      product: product_details
    }

    order_detail = %{status: "lol", quantity: 34, price: 323}
    order_detail_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail)
    |> Changeset.put_assoc(:product, product_details)
    |> Changeset.put_assoc(:partner, product_details.partner)

    #Add Product IDS to the list
    selected_products = List.insert_at(selected_products, -1, order_detail)
    {:noreply,
    socket
    |> assign(:selected_products, selected_products)
    }

  end


  def handle_event("add", %{"value" => value}, %{assigns: %{selected_products: selected_products, }} = socket) do

    result = Enum.fetch(selected_products, String.to_integer(value))
    product = elem(result, 1)

    new_product = Map.update(product, :quantity, 1, fn existing_value -> existing_value + 1 end)
    new_selected_products = List.replace_at(selected_products,  String.to_integer(value), new_product)

    {:noreply,
    socket
    |> assign(:selected_products, new_selected_products)
    }
  end

  def handle_event("sub", %{"value" => value}, %{assigns: %{selected_products: selected_products, }} = socket) do
    result = Enum.fetch(selected_products, String.to_integer(value))
    product = elem(result, 1)

    if product.quantity > 1 do

      new_product = Map.update(product, :quantity, 1, fn existing_value -> existing_value - 1 end)
      new_selected_products = List.replace_at(selected_products,  String.to_integer(value), new_product)

      {:noreply,
      socket
      |> assign(:selected_products, new_selected_products)
      }

    else

      {:noreply,
      socket
      |> assign(:selected_products, selected_products)
      }

    end


  end

  def handle_event("del", %{"value" => value}, %{assigns: %{selected_products: selected_products, }} = socket) do
    #Remove item
    result = List.pop_at(selected_products, String.to_integer(value))
    IO.inspect(result)

    new_selected_products = elem(result, 1)
    {:noreply,
    socket
    |> assign(:selected_products, new_selected_products)
    }
  end

end
