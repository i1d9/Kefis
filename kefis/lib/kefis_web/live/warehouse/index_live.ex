defmodule KefisWeb.Warehouse.IndexLive do
  use KefisWeb, :live_view


  def mount(_params, _session, socket) do

    {
      :ok,
      socket
      |> init_items()
    }
  end

  def init_items(socket) do
    socket
    |> assign(:incoming_count, 0)
    |> assign(:outgoing_count, 0)
    |> assign(:total, 0)
  end



end
