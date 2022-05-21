defmodule KefisWeb.Warehouse.ShowDetailLive do
  use KefisWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id, "type" => type} = _params, _, socket) do
    {:noreply,
     socket
     |> assign(:id, id)
     |> assign(:type, type)}
  end

  def render(assigns) do
    ~H"""
    <div>
    <%= live_component @socket, KefisWeb.Warehouse.ShellDashboardLive, id: "warehouse-dashboard", component: KefisWeb.Warehouse.DetailLive, component_details: %{id: "warehouse-record-details", record_id: @id, type: @type } %>
    </div>
    """
  end
end
