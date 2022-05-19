defmodule KefisWeb.Supplier.Product.IndexLive do
  use KefisWeb, :live_view

  alias Kefis.Repo
  alias Kefis.Products
  alias Kefis.Chain
  alias Kefis.Chain.Product

  def mount(_params, %{"user" => user}, socket) do



    {:ok,
     socket
     |> assign(:user, user)
    }
  end


  def render(assigns) do
    ~H"""
    <%= render_me(assigns, @live_action) %>
    """
  end


  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :list_product, _) do
    socket
    |> assign(:product, nil)
  end

  defp apply_action(socket, :new_product, _) do
    socket
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :show_product, %{"id" => id}) do
    socket
    |> assign(:product, Chain.get_product!(id))
  end

  defp apply_action(socket, :edit_product, %{"id" => id}) do
    socket
    |> assign(:product, Chain.get_product!(id))
  end


  def render_me(assigns, :list_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Product.ListComponent, component_details: %{id: "order_list_component", supplier: @user.partner, live_action: assigns.live_action} %>

    """
  end


  def render_me(assigns, :new_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Product.FormComponent, component_details: %{id: "order_list_component", supplier: @user.partner, product: @product, live_action: assigns.live_action} %>


    """
  end

  def render_me(assigns, :show_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Product.ShowComponent, component_details: %{id: "order_list_component", supplier: @user.partner, product: @product, live_action: assigns.live_action} %>

    """
  end


  def render_me(assigns, :edit_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Supplier.ShellDashboard, user: @user, id: "sdjkds", component: KefisWeb.Supplier.Product.FormComponent, component_details: %{id: "order_list_component",supplier: @user.partner, product: @product, live_action: assigns.live_action} %>

    """
  end
end
