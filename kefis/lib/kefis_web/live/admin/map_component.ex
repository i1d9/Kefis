defmodule KefisWeb.Admin.MapComponent do
  use KefisWeb, :live_component

  def update(%{map_lat: map_lat, map_lng: map_lng} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:map_lat, map_lat)
     |> assign(:map_lng, map_lng)}
  end

  @doc """
  Receive the coordinates from the javascript file
  """
  def handle_event(
        "map_component_coordinates",
        %{"lat" => lat, "lng" => lng} = coordinate,
        socket
      ) do
    IO.inspect(lat)

    send(self(), {:updated_map_component, %{coordinate: coordinate}})

    {:noreply,
     socket
     |> assign(:map_lat, lat)
     |> assign(:map_lng, lng)}
  end

  def get_icon_url(true) do
    "/images/marker.svg"
  end

  def render(assigns) do
    ~H"""
        <leaflet-map zoom={14.5} lat={"#{ @map_lat }"} lng={"#{ @map_lng }"}
      phx-hook="LeafLetAdminMapComponent" phx-update="ignore" phx-target={@myself}>

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
