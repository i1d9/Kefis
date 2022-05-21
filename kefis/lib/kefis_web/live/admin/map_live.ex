defmodule KefisWeb.Admin.MapLive do
  use KefisWeb, :live_component

  alias Kefis.Partners

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(:partners, Partners.list())}
  end

  def get_icon_url(true) do
    "/images/marker.svg"
  end

  # -1.285897,

  def render(assigns) do
    ~H"""

    <div>
        <leaflet-map zoom={14.5} lat={"-1.285897"} lng={"36.817389"}
      phx-hook="LeafLetAdminMapComponent" phx-update="ignore" phx-target={@myself}>

      <%= for partner <- @partners do%>
            <leaflet-marker
            lat={partner.lat}
            lng={partner.lng}
            marker-id={partner.id}
            selected="false"

            phx-value-id="map_component_marker">


        </leaflet-marker>
      <% end %>


    </leaflet-map>
    </div>


    """
  end
end
