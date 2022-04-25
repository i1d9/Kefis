defmodule KefisWeb.Admin.Order.ShowLive do
  use KefisWeb, :live_view

  alias Kefis.Orders

  def mount(params, _session, socket) do
    IO.inspect(params)

    case params do
      %{"id" => id} ->
        {:ok,
         socket
         |> load_order(String.to_integer(id))}

      _ ->
        {:ok, socket}
    end
  end

  def update(%{details: details} = assigns, socket) do
    IO.inspect(assigns)
    IO.inspect(details)

    case details do
      %{order_id: order_id} ->
        {:ok,
         socket
         |> load_order(String.to_integer(order_id))}

      _ ->
        {:ok, socket}
    end

    {:ok, socket}
  end

  defp load_order(socket, id) do
    order = Orders.get_order(id)
    order_details = order.order_details
    retailer = order.partner

    socket
    |> assign(:order, order)
    |> assign(:order_id, order.id)
    |> assign(:order_details, order_details)
    |> assign(:retailer, retailer)
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"id" => id}) do
    socket
    |> load_order(id)
  end

  defp apply_action(socket, :view_detail, %{"id" => id, "detail" => detail}) do
    IO.inspect(detail)

    socket
    |> load_order(id)
    |> assign(:order_detail_id, detail)
  end
end
