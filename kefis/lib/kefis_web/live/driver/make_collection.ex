defmodule KefisWeb.Driver.MakeCollection do
  use KefisWeb, :live_component

  alias Kefis.Collections

  def update(%{info: %{collection_id: id}} = _assigns, socket) do
    IO.inspect(id)

    collection = Collections.driver_get(id)
    %{order_detail: %{partner: partner}}=collection

    IO.inspect(partner)
    {:ok,
     socket
     |> assign(:collection, collection)
     |> assign(:collection_lat, partner.lat)
     |> assign(:collection_lng, partner.lng)
    }
  end

  def handle_event("change_collection_status", value, socket) do
    IO.inspect(value)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>


    <%= live_component @socket, KefisWeb.Driver.MapLive, id: "collection_coordinates" , map_lat: @collection_lat, map_lng: @collection_lng%>

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
