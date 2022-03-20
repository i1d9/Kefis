defmodule KefisWeb.Supplier.MyOrdersLive do

  use KefisWeb, :live_view
  alias Kefis.Repo
  alias Kefis.Orders
  alias Kefis.Chain.Order

  def mount(_params, %{"current_user" => user} = _session, socket) do
    current_user = user |> Repo.preload([:partner, :account])

    {:ok,
    socket
    |> assign(:user, current_user)
    |> assign(:orders, Orders.supplier_orders(current_user.partner))
    }
  end

end
