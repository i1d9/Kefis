defmodule KefisWeb.Driver.OrderLive do
  use KefisWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"type" => type, "id" => id} = params, _url, socket) do
    IO.inspect(params)

    {:noreply,
     socket
     |> assign(:type, type)
     |> assign(:id, id)}
  end

  def render(assigns) do
    ~H"""
    <div>

      <%= case @type do %>
        <% "order_detail" -> %> <%= live_component @socket, KefisWeb.Driver.DashboardNav, id: "dash-nav", title: "Collection ", component: KefisWeb.Driver.MakeCollection, component_info: %{id: "sdklds", collection_id: @id}, description: "Collection Detail" %>
        <% "order" -> %> <%= live_component @socket, KefisWeb.Driver.DashboardNav, id: "dash-nav", title: "Delivery ", component: KefisWeb.Driver.DeliveryLive, component_info: %{id: "sdklds", dispatch_id: @id}, description: "Confirm Deliveries" %>
        <% _ -> %> <div></div>
      <% end%>

    </div>
    """
  end
end
