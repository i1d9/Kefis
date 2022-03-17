defmodule KefisWeb.Retailer.NewOrderLive do

  use KefisWeb, :live_view

  alias Kefis.Products
  import Ecto.Changeset

  @types %{search_phrase: :string}
  defp search_changeset(attrs \\ %{}) do
    cast(
      {%{}, @types},
      attrs,
      [:search_phrase]
    )
    |> validate_required([:search_phrase])
    |> update_change(:search_phrase, &String.trim/1)
    |> validate_length(:search_phrase, min: 2)
    |> validate_format(:search_phrase, ~r/[A-Za-z0-9\ ]/)
  end

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

end
