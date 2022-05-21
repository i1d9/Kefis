defmodule KefisWeb.Driver.MakeCollection do
  use KefisWeb, :live_component

  alias Kefis.Collections

  def update(%{info: %{collection_id: id}} = _assigns, socket) do
    IO.inspect(id)

    collection = Collections.driver_get(id)
    %{order_detail: %{partner: partner}} = collection

    IO.inspect(partner)

    {:ok,
     socket
     |> assign(:collection, collection)
     |> assign(:id, id)
     |> assign(:collection_lat, partner.lat)
     |> assign(:collection_lng, partner.lng)}
  end

  def handle_event(
        "change_collection_status",
        %{"collection_status" => status} = _value,
        %{assigns: %{id: id, collection: collection}} = socket
      ) do
    IO.inspect(status)
    IO.inspect(id)

    case Collections.update(collection, %{status: status}) do
      {:ok, collection} ->
        IO.inspect(collection)

        {:noreply,
         socket
         |> assign(:collection, collection)}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div>

    <h1>
      <%= @collection.order_detail.partner.name %>
    </h1>



    <h1>
    <%= @collection.order_detail.product.name %> X <%= @collection.order_detail.quantity %>
    </h1>

    <%= live_component @socket, KefisWeb.Driver.MapComponent, id: "collection_coordinates" , map_lat: @collection_lat, map_lng: @collection_lng %>

      <%= if @collection.status == "initated" do %>
      <form phx-submit="change_collection_status" phx-target={@myself}>

        <select name="collection_status">
        <option selected disabled>Change Status</option>
        <option phx-value-status="picked">Picked</option>
        </select>

        <button class="btn btn-success">Update</button>

      </form>
      <% end %>



    </div>
    """
  end
end
