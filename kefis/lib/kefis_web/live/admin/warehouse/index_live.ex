defmodule KefisWeb.Admin.Warehouse.IndexLive do
  use KefisWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>

    <%= render_me(@socket, assigns, @live_action) %>

    </div>
    """
  end

  def render_me(socket, assigns, :list) do
    # IO.inspect(assigns)
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "order-detail-modal-component",  component: KefisWeb.Admin.Warehouse.ListComponent, component_details: %{id: "warehouse-list"} %>

    """
  end
end
