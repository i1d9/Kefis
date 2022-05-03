defmodule KefisWeb.Admin.Partner.IndexLive do
  use KefisWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action)}
  end

  defp apply_action(socket, :retailer) do
    socket
  end

  defp apply_action(socket, :supplier) do
    socket
  end


  def render(assigns) do
    ~H"""
    <div>
    <%= if @live_action in [:supplier]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "supplier_component", component: KefisWeb.Admin.Partner.SupplierComponent, component_details: %{id: "dsjkdsjk"} %>
    <% end %>

    <%= if @live_action in [:retailer]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component", component: KefisWeb.Admin.Partner.ReatilerComponent, component_details: %{id: "dsjkdsjk"} %>
    <% end %>
    </div>
    """
  end
end
