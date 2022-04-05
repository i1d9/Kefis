defmodule KefisWeb.Driver.ExampleLive do
  use KefisWeb, :live_component

  def update(_assign, socket) do
    {:ok, socket}
  end



  


  def render(assigns) do
    ~H"""
    <h1>Lol</h1>
    """
  end
end
