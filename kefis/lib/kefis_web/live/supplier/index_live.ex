defmodule KefisWeb.Supplier.IndexLive do
  use KefisWeb, :live_view
  alias Kefis.Orders

  def mount(_params, %{"user" => user}, socket) do
    {:ok,
     socket
     |> assign(user: user)
     |> assign(supplier: user.partner)
     |> assign(:show_detail, false)}
  end

  def render(assigns) do
    ~H"""
      <%= render_me(assigns, @live_action) %>
    """
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :transact_supplier, %{"type" => type}) do
    socket
    |> assign(:type, type)
  end

  defp apply_action(socket, :show_my_orders, %{"id" => id}) do
    socket
    |> assign(:order, Orders.supplier_order_detail(id, socket.assigns.supplier))
  end

  defp apply_action(socket, _, _) do
    socket
  end

  def render_me(assigns, :supplier_home) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Dashboard, component_details: %{id: "order_list_component", supplier: @user.partner,live_action: assigns.live_action} %>

    """
  end

  def render_me(assigns, :list_transactions) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Transaction.ListComponent, component_details: %{id: "order_list_component", user: @user,supplier: @user.partner,live_action: assigns.live_action} %>

    """
  end

  def render_me(assigns, :transact_supplier) do
    ~H"""

    <%= live_modal KefisWeb.Supplier.Transaction.TransactComponent,
    id: "dskjnkjnkj",
    user: @user,
    supplier: @supplier,
    action: @live_action,
    type: @type,

    return_to: Routes.index_path(@socket, :list_transactions) %>


    """
  end

  def render_me(assigns, :show_transaction) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Transaction.ShowComponent, component_details: %{id: "order_list_component", supplier: @user.partner,live_action: assigns.live_action, transaction: @transaction} %>

    """
  end

  def render_me(assigns, :list_my_orders) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Order.ListComponent, component_details: %{id: "order_list_component", supplier: @user.partner, live_action: assigns.live_action} %>

    """
  end

  def render_me(assigns, :show_my_orders) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Order.ShowComponent, component_details: %{id: "order_list_component", supplier: @user.partner,live_action: assigns.live_action, order: @order} %>
    """
  end
end
