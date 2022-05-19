defmodule KefisWeb.Supplier.IndexLive do
  use KefisWeb, :live_view


  def mount(_params, %{"user"=> user}, socket) do
    {:ok,
    socket
    |> assign(:user, user)
  }
  end

  def render(assigns) do
    ~H"""
      <%= render_me(assigns, @live_action) %>
    """
  end


  def render_me(assigns, :supplier_home) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Dashboard, component_details: %{id: "order_list_component", supplier: @user.partner,live_action: assigns.live_action} %>

    """
  end

  def render_me(assigns, :list_transactions) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Transaction.ListComppnent, component_details: %{id: "order_list_component", supplier: @user.partner,live_action: assigns.live_action} %>

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
