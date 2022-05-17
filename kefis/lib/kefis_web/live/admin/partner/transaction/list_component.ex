defmodule KefisWeb.Admin.Partner.Transaction.ListComponent do
  use KefisWeb, :live_component

  def update(%{details: assigns}, socket) do
    IO.inspect(assigns)

    {:ok,
     socket
     |> assign(assigns)}
  end

  def init_items(socket) do
    socket
  end

  def render(assigns) do
    ~H"""
    <div>

    <div class="py-4">



    <%= link "Back", to: Routes.index_path(@socket, :partner_details, 1), class: "btn btn-gray-800 d-inline-flex align-items-center me-2" %>




    </div>
    <div class="card border-0 shadow mb-4">
    <div class="card-body">
    <div class="table-responsive">
    <table class="table table-centered table-nowrap mb-0 rounded">
      <thead>
        <tr>
          <th class="border-0">#</th>
          <th class="border-0">Value</th>
          <th class="border-0">Items</th>
          <th class="border-0">Status</th>
          <th class="border-0">Date</th>
        </tr>
      </thead>
    </table>
    </div>
    </div>
    </div>
    </div>
    """
  end
end
