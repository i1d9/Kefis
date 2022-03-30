defmodule KefisWeb.User.IndexLive do

  use KefisWeb, :live_view


  alias Kefis.Users

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:users, Users.list)
    }
  end

  def handle_params(_params, socket) do
    socket
  end

  defp params_role(socket, %{"role" => "supplier_admin"}) do
    assign(socket, :users, Users.get_supplier)
  end

  defp params_role(socket, %{"role" => "retailer_admin"}) do
    assign(socket, :users, Users.get_supplier)
  end

  defp params_role(socket, %{}) do
    assign(socket, :users, [])
  end

end
