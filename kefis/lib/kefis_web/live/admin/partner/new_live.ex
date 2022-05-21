defmodule KefisWeb.Admin.Partner.NewLive do
  use KefisWeb, :live_view

  alias Kefis.Chain.Partner
  alias Kefis.Chain
  alias Kefis.Users.User
  alias Kefis.Partners

  def mount(_params, %{"user" => user}, socket) do
    partner_changeset = Chain.change_partner(%Partner{})
    user_changeset = User.admin_changeset(%User{}, %{})

    {
      :ok,
      socket
      |> assign(:partner_changeset, partner_changeset)
      |> assign(:user, user)
      |> assign(:user_changeset, user_changeset)
      |> assign(:partner_details_valid, false)
      |> assign(:user_form_visible, false)
      |> assign(map_component_marker_lat: -1.286389, map_component_marker_lng: 36.817223)
    }
  end

  @impl true
  def handle_event("next_page", _value, socket) do
    IO.inspect(socket)

    {:noreply,
     socket
     |> assign(:user_form_visible, true)}
  end

  def handle_event("back_page", _value, socket) do
    IO.inspect(socket)

    {:noreply,
     socket
     |> assign(:user_form_visible, false)}
  end

  def handle_event(
        "user_save",
        %{"user" => _user_params},
        %{assigns: %{partner_changeset: partner_changeset, user_changeset: user_changeset}} =
          socket
      ) do
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
     |> assign(:user_changeset, changeset)}
  end

  def handle_event("partner_save", %{"partner" => partner_params}, socket) do
    IO.inspect(partner_params)
    {:noreply, socket}
  end

  def handle_event("partner_validate", %{"partner" => partner_params}, socket) do
    # IO.inspect(socket)
    changeset =
      Chain.change_partner(%Partner{}, partner_params)
      |> Map.put(:action, :validate)

    {:noreply,
     socket
     |> assign(:partner_changeset, changeset)
     |> assign(:partner_details_valid, changeset.valid?)}
  end

  @impl true
  def handle_info(
        {:updated_map_component, %{coordinate: %{"lat" => lat, "lng" => lng}}},
        %{assigns: %{partner_changeset: partner_changeset}} = socket
      ) do
    changeset =
      partner_changeset
      |> Ecto.Changeset.change(%{lat: lat, lng: lng})
      |> Map.put(:action, :validate)

    IO.inspect(changeset)

    {:noreply,
     socket
     |> assign(map_component_marker_lat: lat, map_component_marker_lng: lng)
     |> assign(:partner_changeset, changeset)}
  end

  def main_component(assigns) do
    ~H"""
    <div class="row">
      <div class="col-12 mb-4">
        <div class="card border-0 shadow components-section">
          <div class="card-body">
            <div class="row mb-4">
              <div class="col-lg-4 col-sm-6">
                <!-- Form -->
                  <div class="mb-4">
                    <%= if @user_form_visible do %>
                        <%= live_component @socket, KefisWeb.Admin.Partner.UserFormComponent, id: "new-user-partner-component", user_changeset: @user_changeset, partner_changeset: @partner_changeset %>
                      <% else %>
                        <%= live_component @socket, KefisWeb.Admin.Partner.PartnerFormComponent, id: "new-partner", user_changeset: @user_changeset, partner_changeset: @partner_changeset, partner_details_valid: @partner_details_valid  %>
                        <%= live_component @socket, KefisWeb.Admin.MapComponent, id: "map-component", map_lat: @map_component_marker_lat, map_lng: @map_component_marker_lng, coordniated: [] %>
                    <% end %>
                  </div>
                <!-- End of Form -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    """
  end
end
