defmodule KefisWeb.Warehouse.OrdersLive do
  use KefisWeb, :live_view

  def mount(_params, %{"user" => user} = _session, socket) do
    {
      :ok,
      socket
      |> assign(:user, user)
      |> assign(:warehouse, user.warehouse)
    }
  end

  def handle_event(
        "show_item",
        %{"id" => id} = _value,
        %{assigns: %{live_action: action}} = socket
      ) do
    {:noreply,
     socket
     |> push_redirect(
       to:
         Routes.live_path(socket, KefisWeb.Warehouse.ShowDetailLive, %{
           "id" => 1,
           "type" => action
         })
     )}
  end
end
