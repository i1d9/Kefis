defmodule KefisWeb.Retailer.NewOrderLive do

  use KefisWeb, :live_view

  alias Kefis.Products
  import Ecto.Changeset


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
    #Add Product IDS to the list
    selected_products = List.insert_at(selected_products, -1, order_detail)
    {:noreply,
    socket
    |> assign(:selected_products, selected_products)
    }

  end


  def handle_event("add", value, %{assigns: %{selected_products: selected_products, }} = socket) do
    new_selected_products = List.replace_at([1, 2, 4, 5], 0, 1)
    IO.inspect(new_selected_products)

    IO.inspect(value)

    {:noreply,
    socket
    |> assign(:lol, "nm")}
  end

  def handle_event("sub", value, socket) do
    new_selected_products = List.replace_at([1, 2, 4, 5], 0, 1)
    IO.inspect(new_selected_products)


    IO.inspect(value)
    {:noreply,
    socket
    }
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
