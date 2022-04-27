defmodule KefisWeb.Driver.MakeCollection do
  use KefisWeb, :live_component

  alias Kefis.Collections

  def update(%{info: %{collection_id: id}} = _assigns, socket) do
    IO.inspect(id)

    {:ok,
     socket
     |> assign(:collection, Collections.driver_get(id))}
  end

  def handle_event("change_collection_status", value, socket) do
    IO.inspect(value)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>

      
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
