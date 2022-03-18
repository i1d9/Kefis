defmodule KefisWeb.Retailer.ConfirmOrderLive do

  use KefisWeb, :live_view


  def mount(params, %{"order" => order} = _session, socket) do
    IO.inspect(params)
    {:ok,
    socket
    |> assign(:order, order)
    }
  end


  
end
