defmodule KefisWeb.Admin.Order.IndexLive do
  use KefisWeb, :live_view

  alias Kefis.Orders

  def mount(params, %{"user" => user}, socket) do
    {:ok,
     socket
     |> init_items()
     |> assign(:user, user)
     |> load_items(params)}
  end

  defp load_items(socket, params) do
    case params do
      %{"id" => id} ->
        socket
        |> assign(order_id: id)

      %{"id" => id, "detail" => detail} ->
        socket
        |> assign(:order_detail_id, 1)

      _ ->
        socket
    end
  end

  def render(assigns) do
    ~H"""
      <div>
      <%= render_me(@socket, assigns, @live_action) %>
      </div>
    """
  end

  def render_me(socket, assigns, :index) do
    ~H"""
      <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive,user: @user, id: "order-list-component",  component: KefisWeb.Admin.Order.ListComponent, component_details: %{id: "order_list_component", live_action: assigns.live_action} %>
    """
  end

  def render_me(socket, assigns, :detail) do
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive,user: @user, id: "order-detail-component",  component: KefisWeb.Admin.Order.ShowLive, component_details: %{id: "order_detail_component",order_id: @order_id, live_action: @live_action, modal: false} %>

    """
  end

  def render_me(socket, assigns, :info) do
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, user: @user,id: "order-detail-modal-component",  component: KefisWeb.Admin.Order.ShowLive, component_details: %{id: "order_detail_component",order_id: @order_id, live_action: @live_action, modal: true, detail: @order_detail_id} %>

    """
  end

  def handle_params(params, _url, socket) do
    case params do
      %{"id" => _id, "detail" => detail} ->
        {:noreply,
         socket
         |> assign(:order_detail_id, detail)}

      _ ->
        {:noreply, socket}
    end
  end

  defp init_items(socket) do
    items = Orders.admin_list_orders()

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

  def handle_event(
        "change_page",
        %{"index" => index} = _params,
        %{assigns: %{paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(String.to_integer(index))
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, String.to_integer(index))
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{assigns: %{page_number: page_number, paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(page_number + 1)
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number + 1)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{assigns: %{page_number: page_number, paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(page_number - 1)
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number - 1)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event("edit_item", %{"id" => id} = _params, socket) do
    {:noreply, socket}
  end

  def handle_event("delete_item", %{"id" => id} = _params, socket) do
    order = Orders.get(String.to_integer(id))

    case Orders.delete(order) do
      {:ok, _deleted_product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Delete Order")
         |> init_items()}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end
end
