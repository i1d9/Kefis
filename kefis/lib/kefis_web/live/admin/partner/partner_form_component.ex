defmodule KefisWeb.Admin.Partner.PartnerFormComponent do
  use KefisWeb, :live_component

  def update(
        %{
          partner_details_valid: partner_details_valid,
          partner_changeset: partner_changeset,
          user_changeset: user_changeset
        } = assigns,
        socket
      ) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:partner_changeset, partner_changeset)
     |> assign(:user_changeset, user_changeset)
     |> assign(:partner_details_valid, partner_details_valid)}
  end

  def render(assigns) do
    ~H"""

    <div>

    <div>
    <.form let={partner_f} for={@partner_changeset}

                          phx-change="partner_validate"
              phx-submit="partner_save"
                        id="admin-partner-form"
                          >


    <div class="mb-4">
      <%= label partner_f, :name, for: "name" %>
      <%= text_input partner_f, :name, class: "form-control", id: "name" %>
      <%= error_tag partner_f, :name %>
    </div>

      <div class="mb-4">
      <%= label partner_f, :location, for: "name" %>
      <%= text_input partner_f, :location, class: "form-control", id: "location" %>
      <%= error_tag partner_f, :location %>
      </div>

      <div class="mb-4">
      <%= label partner_f, :phone %>
      <%= text_input partner_f, :phone, class: "form-control", id: "phone" %>
      <%= error_tag partner_f, :phone %>
      </div>

      <div class="mb-4">
      <%= label partner_f, :email, for: "email" %>
      <%= text_input partner_f, :email, class: "form-control", id: "email" %>
      <%= error_tag partner_f, :email %>
      </div>

      <div class="mb-4" style="display: none">
      <%= label partner_f, :lng, for: "lng" %>
      <%= number_input partner_f, :lng, class: "form-control", id: "lng", step: "any" %>
      <%= error_tag partner_f, :lng %>
      </div>

      <div class="mb-4" style="display: none">
      <%= label partner_f, :lat, for: "lat" %>
      <%= number_input partner_f, :lat, class: "form-control", id: "lng", step: "any" %>
      <%= error_tag partner_f, :lat %>
      </div>

      <div class="mb-4">
      <%= label partner_f, :type, class: "my-1 me-2", for: "country"%>

      <%= select(partner_f, :type,  [[key: "Retailer", value: "retailer", ],
                        [key: "Supplier", value: "supplier"]], class: "form-select") %>
      <%= error_tag partner_f, :type %>
      </div>




    <%= if @partner_details_valid do %>
        <button type="button" phx-click="next_page" class="btn btn-success"> Next</button>
    <% end %>


    </.form>
    </div>

    </div>

    """
  end
end
