defmodule KefisWeb.Admin.Partner.FormComponent do
  use KefisWeb, :live_component
  alias Kefis.Partners
  alias Kefis.Chain
  alias Kefis.Chain.Partner

  def update(%{details: %{partner: partner, type: type}} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(changeset: Chain.change_partner(partner))
     |> assign(:partner_details_valid, false)
     |> assign(:type, type)
     |> assign(map_component_marker_lat: -1.286389, map_component_marker_lng: 36.817223)}
  end

  def render(assigns) do
    ~H"""
    <div class="row">
    <div class="col-12 mb-4">
    <div class="card border-0 shadow">
    <div class="card-body">
    <div class="row mb-4">
    <div class="col-lg-4 col-sm-6">
      <!-- Form -->
        <div class="mb-4">

              <.form let={partner_f} for={@changeset}

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





              </.form>
    </div></div></div>
    </div>
    </div>
    </div>
    </div>
    """
  end

  
end
