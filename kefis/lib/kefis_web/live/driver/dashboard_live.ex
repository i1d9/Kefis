defmodule KefisWeb.Driver.DashboardLive do
  use KefisWeb, :live_view


  def mount(_params, session, socket) do
    IO.inspect(session)
    {:ok, socket}
  end

  


end
