defmodule KefisWeb.Retailer.ConfirmOrderLive do

  use KefisWeb, :live_view

  def mount(_params, _session, socket) do
    IO.inspect(socket)
    {:ok, socket
    }
  end
end
