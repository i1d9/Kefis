defmodule KefisWeb.Retailer.ConfirmOrderLive do
  use KefisWeb, :live_view

  def mount(_params, %{"order" => order} = _session, socket) do
    # IO.inspect(order.order_details)
    _filters = %{"name" => true, "supplier" => true, "value" => true, "price" => true}

    {:ok,
     socket
     |> assign(:order, order)
     |> assign(:order_holder, order)}
  end

  def handle_event(
        "table_filter",
        %{"filter" => filter} = _value,
        %{assigns: %{order: order, order_holder: order_holder}} = socket
      ) do
    IO.inspect(order.order_details)

    {:noreply,
     socket
     |> assign(:order, filter_order_details(order, filter, order_holder))}
  end

  defp filter_order_details(order, feature, holder) do
    case feature do
      "reset" ->
        holder

      "name" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.product.name, :asc)
        end)

      "nameD" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.product.name, :desc)
        end)

      "price" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.product.price, :asc)
        end)

      "priceD" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.product.price, :desc)
        end)

      "supplier" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.partner.name, :asc)
        end)

      "supplierD" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.partner.name, :desc)
        end)

      "quantity" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.quantity, :asc)
        end)

      "quantityD" ->
        Map.update!(order, :order_details, fn _ ->
          Enum.sort_by(order.order_details, & &1.quantity, :desc)
        end)

      _ ->
        holder
    end
  end
end
