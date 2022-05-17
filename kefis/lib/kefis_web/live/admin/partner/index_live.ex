defmodule KefisWeb.Admin.Partner.IndexLive do
  use KefisWeb, :live_view

  alias Kefis.Chain.Partner
  alias Kefis.Chain
  alias Kefis.Users.User
  alias Kefis.Partners

  def mount(_params, %{"user" => user}, socket) do
    {:ok,
    socket
    |> assign(:user, user)
    }
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end


  defp apply_action(socket, :edit_partner, %{"id" => id} = params) do

    IO.inspect(id)
    socket
    |> assign(:partner, Chain.get_partner!(id))
  end


  defp apply_action(socket, :retailer, params) do
    socket
  end

  defp apply_action(socket, :supplier, params) do
    socket
  end


  defp apply_action(socket, :partner_details, %{"id" => id} = params) do
    socket
    |> assign(:partner, Chain.get_partner!(id))
  end


  defp apply_action(socket, :partner_order, %{"id" => id} = params) do
    socket
    |> assign(:partner, Chain.get_partner!(id))
  end


  defp apply_action(socket, :partner_order_details, %{"id" => id} = params) do
    socket
    |> assign(:partner, Chain.get_partner!(id))
  end


  defp apply_action(socket, :partner_transactions, %{"id" => id} = params) do
    socket
    |> assign(:partner, Chain.get_partner!(id))
  end




  def render(assigns) do
    ~H"""
    <div>



    <%= if @live_action in [:supplier]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "supplier_component",user: @user, component: KefisWeb.Admin.Partner.SupplierComponent, component_details: %{id: "dsjkdsjk"} %>
    <% end %>

    <%= if @live_action in [:retailer]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component",user: @user, component: KefisWeb.Admin.Partner.ReatilerComponent, component_details: %{id: "dsjkdsjk"} %>
    <% end %>

    <%= if @live_action in [:edit_partner]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component",user: @user, component: KefisWeb.Admin.Partner.FormComponent, component_details: %{id: "dsjkdsjk", partner: @partner} %>
    <% end %>

    <%= if @live_action in [:partner_details]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component",user: @user, component: KefisWeb.Admin.Partner.DetailComponent, component_details: %{id: "dsjkdsjk", partner: @partner} %>
    <% end %>

    <%= if @live_action in [:partner_order]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component",user: @user, component: KefisWeb.Admin.Partner.Order.ListComponent, component_details: %{id: "dsjkdsjk", partner: @partner} %>
    <% end %>

    <%= if @live_action in [:partner_order_details]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component",user: @user, component: KefisWeb.Admin.Partner.Order.DetailComponent, component_details: %{id: "dsjkdsjk", partner: @partner} %>
    <% end %>

    <%= if @live_action in [:partner_transactions]  do%>
    <%= live_component @socket, KefisWeb.Admin.ShellDashboardLive, id: "retailer_component",user: @user, component: KefisWeb.Admin.Partner.Transaction.ListComponent, component_details: %{id: "dsjkdsjk", partner: @partner} %>
    <% end %>



    </div>
    """
  end



  @impl true
  def handle_event("next_page", _value, socket) do
    IO.inspect(socket)
    {:noreply,
    socket
    |> assign(:user_form_visible, true)
    }
  end

  def handle_event("back_page", _value, socket) do
    IO.inspect(socket)
    {:noreply,
    socket
    |> assign(:user_form_visible, false)
    }
  end



  def handle_event("user_save", %{"user" => _user_params}, %{assigns: %{partner_changeset: partner_changeset, user_changeset: user_changeset }} = socket) do
    IO.inspect(socket)

    user_changeset =
      user_changeset
      |> Map.put(:action, :insert)

    partner_changeset =
      partner_changeset
      |> Map.put(:action, :insert)

    case Partners.create_partner_changeset(partner_changeset, user_changeset) do
      {:ok, _partner} ->
        {:noreply, redirect(socket, to: Routes.admin_path(socket, :index))}
      {:error, %Ecto.Changeset{} = _changeset} ->
        {:noreply, socket}
    end


  end

  def handle_event("user_validate", %{"user" => user_parmas}, socket) do
    changeset =
      User.admin_changeset(%User{}, user_parmas)
      |> Map.put(:action, :validate)
    {:noreply,
    socket
    |> assign(:user_changeset, changeset)

    }
  end


  def handle_event("partner_save", %{"partner" => partner_params}, socket) do

    IO.inspect(partner_params)
    {:noreply, socket}
  end

  def handle_event("partner_validate", %{"partner" => partner_params}, socket) do

    #IO.inspect(socket)
    changeset =
      Chain.change_partner(%Partner{}, partner_params)
      |> Map.put(:action, :validate)
    {:noreply,
    socket
    |> assign(:partner_changeset, changeset)
    |> assign(:partner_details_valid, changeset.valid?)
    }
  end


  @impl true
  def handle_info({:updated_map_component, %{coordinate: %{"lat" => lat, "lng" => lng}}}, %{assigns: %{partner_changeset: partner_changeset}} = socket) do

    changeset =
      partner_changeset
      |> Ecto.Changeset.change(%{lat: lat, lng: lng})
      |> Map.put(:action, :validate)
    IO.inspect(changeset)
    {:noreply,
    socket
    |> assign(map_component_marker_lat: lat, map_component_marker_lng: lng)
    |> assign(:partner_changeset, changeset)
    }
  end


end
