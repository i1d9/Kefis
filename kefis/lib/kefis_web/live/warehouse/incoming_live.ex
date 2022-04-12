defmodule KefisWeb.Warehouse.IncomingLive do
  use KefisWeb, :live_component


  def update(assigns, socket) do
    {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <div>
    <h1>Incoming Orders</h1>
    <table class="table table-centered table-nowrap mb-0 rounded">
    <thead>
    <tr>
    <th>Driver</th>
    <th>Vehicle</th>
    <th>Value</th>
    <th>Actions</th>
    </tr>
    </thead>
    <tbody>

    </tbody>
    </table>
    </div>
    """
  end

end
