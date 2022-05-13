defmodule KefisWeb.Admin.Partner.Order.ListComponent do
  use KefisWeb, :live_component

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
    }
  end

  def render(assigns) do
    ~H"""
    <div></div>
    """
  end
end
