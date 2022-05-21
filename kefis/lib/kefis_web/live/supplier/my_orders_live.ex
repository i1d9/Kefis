defmodule KefisWeb.Supplier.MyOrdersLive do
  use KefisWeb, :live_view
  alias Kefis.Repo
  alias Kefis.Orders

  def mount(_params, %{"current_user" => user} = _session, socket) do
    current_user = user |> Repo.preload([:partner])

    {:ok,
     socket
     |> assign(:user, current_user)
     |> init_items(current_user)}
  end

  defp init_items(socket, current_user, status \\ "initiated") do
    orders = Orders.supplier_orders(current_user.partner, status)

    page_entries = 10
    paginated_orders = orders |> Enum.chunk_every(page_entries)
    orders_for_page = paginated_orders |> Enum.at(0)
    total_entries = orders |> Enum.count()
    total_pages = paginated_orders |> Enum.count()

    socket
    |> assign(:orders, orders)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_orders, paginated_orders)
    |> assign(:orders_for_page, orders_for_page)
    |> assign(:page_entries, page_entries)
  end

  def handle_event(
        "change_page",
        %{"index" => index} = _params,
        %{assigns: %{paginated_orders: paginated_orders}} = socket
      ) do
    orders_for_page = paginated_orders |> Enum.at(String.to_integer(index))
    page_entries = orders_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, String.to_integer(index))
     |> assign(:orders_for_page, orders_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{assigns: %{page_number: page_number, paginated_orders: paginated_orders}} = socket
      ) do
    orders_for_page = paginated_orders |> Enum.at(page_number + 1)
    page_entries = orders_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number + 1)
     |> assign(:orders_for_page, orders_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{assigns: %{page_number: page_number, paginated_orders: paginated_orders}} = socket
      ) do
    orders_for_page = paginated_orders |> Enum.at(page_number - 1)
    page_entries = orders_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number - 1)
     |> assign(:orders_for_page, orders_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event("order", _params, socket) do
    {:noreply, socket}
  end

  def handle_event(
        "filter_status",
        %{"status" => status},
        %{assigns: %{user: current_user}} = socket
      ) do
    IO.inspect(status)
    IO.inspect(current_user)

    {:noreply,
     socket
     |> init_items(current_user, status)}
  end
end
