defmodule KefisWeb.Admin.IndexLive do
  use KefisWeb, :live_view


  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>





    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "order-list-component",  component: KefisWeb.Admin.DashboardComponent, component_details: %{id: "order_list_component", live_action: assigns.live_action} %>

    </div>
    """
  end
end
