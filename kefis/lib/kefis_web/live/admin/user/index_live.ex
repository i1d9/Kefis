defmodule KefisWeb.Admin.User.IndexLive do
  use KefisWeb, :live_view

  alias Kefis.Users

  def mount(_params, %{"user" => user}, socket) do
    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:users, Users.list())}
  end

  def handle_params(_params, socket) do
    socket
  end

  defp params_role(socket, %{"role" => "supplier_admin"}) do
    assign(socket, :users, Users.get_supplier())
  end

  defp params_role(socket, %{"role" => "retailer_admin"}) do
    assign(socket, :users, Users.get_supplier())
  end

  defp params_role(socket, %{}) do
    assign(socket, :users, [])
  end

  def main_component(assigns) do
    ~H"""
    <div class="card border-0 shadow mb-4">
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-centered table-nowrap mb-0 rounded">
                <thead class="thead-light">
                    <tr>
                        <th class="border-0 rounded-start">#</th>
                        <th class="border-0">First Name</th>
                        <th class="border-0">Second Name</th>
                        <th class="border-0">Email</th>
                        <th class="border-0">Phone</th>
                        <th class="border-0">Role</th>


                        <th class="border-0 rounded-end">Actions</th>
                    </tr>
                </thead>
                <tbody>

        <%= for {user, index} <- Enum.with_index(@users, 1) do %>
        <tr>
        <td><%= index %></td>
        <td><%= user.first_name %></td>
        <td><%= user.second_name %></td>
              <td><%= user.email %></td>
                    <td><%= user.phone %></td>
                          <td><%= user.role %></td>
                          <td>
                          <div class="btn btn-warning">Edit</div>
                                                        <div class="btn btn-danger">Delete</div>
                          </td>
        </tr>
        <% end %>
              </tbody>
                    </table>
                </div>
            </div>
        </div>
    """
  end
end
