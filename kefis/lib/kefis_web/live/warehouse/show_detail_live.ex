defmodule KefisWeb.Warehouse.ShowDetailLive do
  use KefisWeb, :live_view


  def mount(_params,_session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}=_params, _, socket) do
    {:noreply,
    socket
    |> assign(:id, id)
    }
  end

  def render(assigns) do
    ~H"""
    <div>
    <%= live_component @socket, KefisWeb.Warehouse.ShellDashboardLive, id: "outgoing_page", component: KefisWeb.Warehouse.DetailLive, component_details: %{id: "dsjkdsjk", collection_id: @id } %>
    </div>
    """
  end
end
