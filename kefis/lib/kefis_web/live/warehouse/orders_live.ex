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

  

end
