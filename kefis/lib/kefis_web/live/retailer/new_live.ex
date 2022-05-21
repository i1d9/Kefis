defmodule KefisWeb.Retailer.NewLive do
  use KefisWeb, :live_view

  def mount(_, %{"user" => user} = _session, socket) do
    IO.inspect(user)

    {:ok,
     socket
     |> assign(user: user)}
  end
end
