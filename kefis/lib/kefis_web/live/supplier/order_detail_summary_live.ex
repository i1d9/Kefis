defmodule KefisWeb.Supplier.OrderDetailSummaryLive do
  use KefisWeb, :live_view

  alias Kefis.Repo
  alias Kefis.Orders

  def mount(_params, %{"user" => user, "order_detail" => order_detail} = _session, socket) do
    {:ok,
      socket
      |> assign(:user, user)
      |> assign(:order, order_detail)

    }
  end


  def handle_event("change_order_detail_status", %{"status" => status}= _value, %{assigns: %{order: order, }} = socket) do

    case Orders.update_order_detail(order, %{status: status}) do
      {:ok, order} ->
        IO.inspect(order)
        {:noreply,
          socket
          |> assign(:order, order)
        }
      {:error, error} ->
        IO.inspect(error)
        {:noreply, socket}

    end

  end



end
