defmodule KefisWeb.Admin.Transaction.IndexLive do
  use KefisWeb, :live_view

  def mount(_params, %{"user" => user}, socket) do
    IO.inspect(socket.assigns.live_action)
    {:ok,
    socket
    |> assign(:user, user)

    }
  end



  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action)}
  end

  defp apply_action(socket, :transaction_index) do
    socket
  end

  def render_me(socket, assigns, :transaction_index) do
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "transaction_component",user: @user, component: KefisWeb.Admin.Transaction.ListComponent, description: "sdkjnsdjkn", component_details: %{id: "dsjkdsjk"} %>
    """
  end

  def render(assigns) do
    ~H"""
      <div>
      <%= render_me(@socket, assigns, @live_action) %>
      </div>
    """
  end


end
