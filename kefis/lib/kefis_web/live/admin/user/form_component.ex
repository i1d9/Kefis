defmodule KefisWeb.Admin.User.FormComponent do
  use KefisWeb, :live_component

  def update(
        %{partner_changeset: partner_changeset, user_changeset: user_changeset} = assigns,
        socket
      ) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:partner_changeset, partner_changeset)
     |> assign(:user_changeset, user_changeset)}
  end
end
