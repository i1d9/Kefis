defmodule KefisWeb.Retailer.NewOrderLive do
  use KefisWeb, :live_view

  alias Kefis.Products
  alias Kefis.Chain.OrderDetail
  alias Kefis.Orders
  alias Ecto.Changeset
  alias Kefis.Repo

  @impl true
  def mount(_params, %{"current_user" => user} = _session, socket) do
    products = Products.list_products()
    current_user = user |> Repo.preload([:partner])

    {:ok,
     socket
     |> assign(:user, current_user)
     |> assign(:total, 0)
     |> assign(:finished_selection, false)
     |> assign(:selected_products, [])
     |> assign(:selected_products_id, [])
     |> assign(:products, products)
     |> init_items()}
  end

  defp init_items(socket) do
    items = Products.list_products()

    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    socket
    |> assign(:items, items)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_items, paginated_items)
    |> assign(:items_for_page, items_for_page)
    |> assign(:page_entries, page_entries)
  end

  @impl true
  def handle_event("type_search", %{"search" => %{"product_name" => search}}, socket) do
    products = Products.search_product(search)
    {:noreply, assign(socket, :products, products)}
  end

  @impl true
  def handle_event(
        "toggle_finished",
        _value,
        %{assigns: %{finished_selection: finished_selection}} = socket
      ) do
    {:noreply, assign(socket, :finished_selection, !finished_selection)}
  end

  @impl true
  def handle_event(
        "product_click",
        %{"value" => value},
        %{assigns: %{selected_products: selected_products, total: total}} = socket
      ) do
    product_details = Products.find(value)

    new_total = 1 * product_details.price + total
    order_detail = %{status: "initiated", quantity: 1, price: product_details.price}

    order_detail_changeset =
      OrderDetail.changeset(%OrderDetail{}, order_detail)
      |> Changeset.put_assoc(:product, product_details)
      |> Changeset.put_assoc(:partner, product_details.partner)

    # Add Product IDS to the list
    selected_products = Enum.uniq(List.insert_at(selected_products, -1, order_detail_changeset))

    {:noreply,
     socket
     |> assign(:selected_products, selected_products)
     |> assign(:total, new_total)}
  end

  def handle_event(
        "add",
        %{"value" => value},
        %{assigns: %{selected_products: selected_products, total: total}} = socket
      ) do
    {_status, product} = Enum.fetch(selected_products, String.to_integer(value))

    order_detail_changeset = Ecto.Changeset.update_change(product, :quantity, &(&1 + 1))

    new_selected_products =
      List.replace_at(selected_products, String.to_integer(value), order_detail_changeset)

    new_total = total + order_detail_changeset.changes.price

    {:noreply,
     socket
     |> assign(:selected_products, new_selected_products)
     |> assign(:total, new_total)}
  end

  def handle_event(
        "sub",
        %{"value" => value},
        %{assigns: %{selected_products: selected_products, total: total}} = socket
      ) do
    {_status, product} = Enum.fetch(selected_products, String.to_integer(value))

    if product.changes.quantity > 1 do
      order_detail_changeset = Ecto.Changeset.update_change(product, :quantity, &(&1 - 1))

      new_selected_products =
        List.replace_at(selected_products, String.to_integer(value), order_detail_changeset)

      new_total = total - order_detail_changeset.changes.price

      {:noreply,
       socket
       |> assign(:selected_products, new_selected_products)
       |> assign(:total, new_total)}
    else
      {:noreply,
       socket
       |> assign(:selected_products, selected_products)}
    end
  end

  def handle_event(
        "del",
        %{"value" => value},
        %{assigns: %{selected_products: selected_products, total: total}} = socket
      ) do
    # Remove item
    {removed_product, new_selected_products} =
      List.pop_at(selected_products, String.to_integer(value))

    new_total = total - removed_product.changes.quantity * removed_product.changes.price

    {:noreply,
     socket
     |> assign(:selected_products, new_selected_products)
     |> assign(:total, new_total)}
  end

  def handle_event(
        "submit_order",
        _value,
        %{assigns: %{selected_products: selected_product_changesets, total: total, user: user}} =
          socket
      ) do
    order_info = %{value: total, status: "Initiatied", date: Date.utc_today()}

    case Orders.retailer_new_order(order_info, user, selected_product_changesets) do
      {:ok, order} ->
        {:noreply,
         socket
         |> redirect(to: Routes.retailer_path(socket, :show_order, order.id))}

      {:error, _changeset} ->
        {:noreply,
         socket
         |> assign(:selected_products, selected_product_changesets)}
    end
  end
end
