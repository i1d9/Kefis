defmodule KefisWeb.Retailer.OrdersLive do
  use KefisWeb, :live_view

  def mount(_, %{"user" => user }= _session, socket) do
    {:ok,
    socket
    |> assign(user: user)
    |> assign(:show_detail, false)
    }
  end

  def handle_params(_,_, socket) do
    {:noreply, socket}
  end


  @impl true
  def handle_event("show_item", %{"id" => id }=_params, socket) do

    {:noreply,
    socket
    |> assign(:show_detail, true)
    |> assign(:order_detail_id, id)
    }
  end



  def handle_event("show_orders", _value, socket) do

    {:noreply,
    socket
    |> assign(:show_detail, false)
    }
  end



end
