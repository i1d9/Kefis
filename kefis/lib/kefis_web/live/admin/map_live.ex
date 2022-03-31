defmodule KefisWeb.Admin.MapLive do
  use KefisWeb, :live_component

  def update(%{map_lat: map_lat, map_lng: map_lng  } = assigns, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> assign(:map_lat, map_lat)
    |> assign(:map_lng, map_lng)
    }
  end


  def handle_event("map_component_coordinates", %{"lat"=> lat, "lng"=> lng} = coordinate, socket) do

    IO.inspect(lat)

    send self(), {:updated_map_component, %{coordinate: coordinate}}

    {:noreply,
    socket
    |> assign(:map_lat, lat)
    |> assign(:map_lng, lng)
    }
  end

  def get_icon_url(true) do
    "/images/dark-elixir-icon.png"
  end

end
