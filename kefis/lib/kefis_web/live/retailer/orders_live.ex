defmodule KefisWeb.Retailer.OrdersLive do
  use KefisWeb, :live_view
  alias Kefis.Orders

  alias Kefis.Transactions
  def mount(_, %{"user" => user} = _session, socket) do


    {:ok,
     socket
     |> assign(user: user)
     |> assign(retailer: user.partner)
     |> assign(:show_detail, false)}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("show_item", %{"id" => id} = _params, socket) do
    {:noreply,
     socket
     |> assign(:show_detail, true)
     |> assign(:order_detail_id, id)}
  end

  def handle_event("show_orders", _value, socket) do
    {:noreply,
     socket
     |> assign(:show_detail, false)}
  end

  def render(assigns) do
    ~H"""
    <div>

      <%= render_me(assigns, @live_action)%>

    </div>
    """
  end

  def render_me(assigns, :show_order) do
    ~H"""
    <%= live_component @socket, KefisWeb.Retailer.ShellDashboardLive,user: @user, id: "order_details", user: @user, component: KefisWeb.Retailer.OrderDetailsLive, component_details: %{id: "order_list_component", user: @user, order: @order} %>
    """
  end

  def render_me(assigns, :index) do
    ~H"""
    <%= live_component @socket, KefisWeb.Retailer.ShellDashboardLive,user: @user, id: "order_list", component: KefisWeb.Retailer.OrdersListLive, component_details: %{id: "order_list_component", user: @user, live_action: @live_action} %>
    """
  end

  def render_me(assigns, :list_my_transaction) do
    ~H"""
    <%= live_component @socket, KefisWeb.Retailer.ShellDashboardLive,user: @user, id: "order_list", component: KefisWeb.Retailer.Transaction.ListComponent, component_details: %{id: "order_list_component", user: @user, live_action: @live_action} %>
    """
  end


  def render_me(assigns, :show_my_transaction) do
    ~H"""
    <%= live_component @socket, KefisWeb.Retailer.ShellDashboardLive,user: @user, id: "order_list", component: KefisWeb.Retailer.Transaction.ShowComponent, component_details: %{id: "order_list_component", user: @user, live_action: @live_action} %>
    """
  end

  def render_me(assigns, :transact) do
    ~H"""

    <%= live_modal KefisWeb.Retailer.Transaction.TransactComponent,
    id: "dskjnkjnkj",
    user: @user,
    retailer: @retailer,
    action: @live_action,
    type: @type,

    return_to: Routes.orders_path(@socket, :list_my_transaction) %>


    """
  end

  defp apply_action(socket, :show_order, %{"id"=> id}) do
    socket
    |> assign(:order, Orders.get(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
  end


  defp apply_action(socket, :list_my_transaction, _) do
    socket
  end

  defp apply_action(socket, :transact, %{"type" => type}) do
    socket
    |> assign(:type, type)
  end

  defp apply_action(socket, :show_my_transaction, %{"id"=> id}) do
    socket
    |> assign(:transaction, Transactions.get_transaction!(id))
  end
end
