defmodule KefisWeb.Driver.MapComponent do
  use KefisWeb, :live_component

  def update(%{map_lat: map_lat, map_lng: map_lng} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:map_lat, map_lat)
     |> assign(:map_lng, map_lng)}
  end

  def get_icon_url(socket) do
    Routes.static_path(socket, "/images/live_view_upload-1648673659-829040224941413-3")
  end

  def render(assigns) do
    ~H"""
    <leaflet-map zoom={14.5} lat={"#{ @map_lat }"} lng={"#{ @map_lng }"}
      phx-update="ignore" phx-target={@myself}>

    <leaflet-marker
          lat={"#{ @map_lat }"}
          lng={"#{ @map_lng }"}
          marker-id="map_component_marker"
          selected="false"

          phx-value-id="map_component_marker">
          <leaflet-icon
            icon-url={get_icon_url(@socket)}
            width="64"
            height="64">
          </leaflet-icon>
      </leaflet-marker>

    </leaflet-map>


    """
  end
end
