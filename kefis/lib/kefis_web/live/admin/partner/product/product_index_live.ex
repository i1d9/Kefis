defmodule KefisWeb.Admin.Partner.Product.IndexLive do
  use KefisWeb, :live_view

  alias Kefis.Chain.Product
  alias Kefis.Products
  alias Kefis.Partners

  def mount(_params, %{"user" => user}, socket) do
    {:ok,
     socket
     |> assign(:user, user)}
  end

  def render(assigns) do
    ~H"""
    <div>

      <%= render_me(assigns, @live_action) %>

    </div>
    """
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :partner_products, %{"id" => id}) do
    socket
    |> assign(:supplier, Partners.get!(id))
  end

  defp apply_action(socket, :new_partner_product, %{"id" => id}) do
    socket
    |> assign(:supplier, Partners.get!(id))
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :show_partner_product, %{"id" => id, "product" => product}) do
    socket
    |> assign(:supplier, Partners.get!(id))
    |> assign(:product, Products.get!(product))
  end

  defp apply_action(socket, :edit_partner_product, %{"id" => id, "product" => product}) do
    socket
    |> assign(:supplier, Partners.get!(id))
    |> assign(:product, Products.get!(product))
  end

  defp render_me(assigns, :partner_products) do
    ~H"""

    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "supplier_component",user: @user, component: KefisWeb.Admin.Partner.Product.ListComponent, component_details: %{id: "dsjkdsjk", supplier: @supplier, live_action: @live_action} %>

    """
  end

  defp render_me(assigns, :new_partner_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "supplier_component",user: @user, component: KefisWeb.Admin.Partner.Product.FormComponent, component_details: %{id: "dsjkdsjk", product: @product, supplier: @supplier, live_action: @live_action} %>

    """
  end

  defp render_me(assigns, :show_partner_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "supplier_component",user: @user, component: KefisWeb.Admin.Partner.Product.ShowComponent, component_details: %{id: "dsjkdsjk", product: @product, supplier: @supplier, live_action: @live_action} %>

    """
  end

  defp render_me(assigns, :edit_partner_product) do
    ~H"""
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "supplier_component",user: @user, component: KefisWeb.Admin.Partner.Product.FormComponent, component_details: %{id: "dsjkdsjk", product: @product, supplier: @supplier, live_action: @live_action} %>

    """
  end
end
