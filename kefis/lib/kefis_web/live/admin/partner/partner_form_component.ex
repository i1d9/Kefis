defmodule KefisWeb.Admin.Partner.PartnerFormComponent do
  use KefisWeb, :live_component


  def update(%{partner_details_valid: partner_details_valid, partner_changeset: partner_changeset, user_changeset: user_changeset} = assigns, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> assign(:partner_changeset, partner_changeset)
    |> assign(:user_changeset, user_changeset)
    |> assign(:partner_details_valid, partner_details_valid)
    }
  end







end
