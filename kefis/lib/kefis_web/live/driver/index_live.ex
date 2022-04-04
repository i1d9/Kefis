defmodule KefisWeb.Driver.IndexLive do
  use KefisWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
