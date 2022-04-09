defmodule KefisWeb.Driver.ExampleLive do
  use KefisWeb, :live_component

  def update(_assign, socket) do
    {:ok, socket}
  end






  def render(assigns) do
    ~H"""
    <div>
    <h1>Lol</h1>

    <%= live_patch "Collections", to: Routes.trips_path(@socket, :collections ) %>
    <%= live_patch "Deliveries", to: Routes.trips_path(@socket, :delivery ) %>

    </div>
    """
  end
end
