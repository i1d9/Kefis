defmodule KefisWeb.Admin.Order.DetailLive do
  use KefisWeb, :live_view

  alias Kefis.Orders
  def mount(params, _session, socket) do

    case params do
      %{"id" => id} ->

        {:ok,
          load_order(socket, String.to_integer(id))}
      _ ->
        {:ok, socket}
    end

  end

  def handle_params( params, _url, socket) do


    case params do
      %{"id" => id} ->
        {:noreply,
        load_order(socket, String.to_integer(id))
        }

      _ ->
        {:ok, socket}
    end



  end

  defp load_order(socket, id) do
    order = Orders.get_order(id)
    order_details = order.order_details
    retailer = order.partner

    IO.inspect(order_details)
    socket
    |> assign(:order, order)
    |> assign(:order_details, order_details)
    |> assign(:retailer, retailer)
  end





end
