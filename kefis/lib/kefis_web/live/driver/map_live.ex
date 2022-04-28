defmodule KefisWeb.Driver.MapLive do
  use KefisWeb, :live_component

  def update(%{map_lat: map_lat, map_lng: map_lng  } = assigns, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> assign(:map_lat, map_lat)
    |> assign(:map_lng, map_lng)
    }
  end

  def get_icon_url(true) do
    "/images/marker.svg"
  end

  def render(assigns) do
    ~H"""
    <leaflet-map lat={"#{ @map_lat }"} lng={"#{ @map_lng }"}
      phx-update="ignore" phx-target={@myself}>

    <leaflet-marker
          lat={"#{ @map_lat }"}
          lng={"#{ @map_lng }"}
          marker-id="map_component_marker"
          selected="false"

          phx-value-id="map_component_marker">
          <leaflet-icon
            icon-url={get_icon_url(true)}
            width="64"
            height="64">
          </leaflet-icon>
      </leaflet-marker>

    </leaflet-map>


    """
  end
end
