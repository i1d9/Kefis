defmodule KefisWeb.Admin.Partner.UserFormComponent do
  use KefisWeb, :live_component
  alias Kefis.Users.User


  def update(%{partner_changeset: partner_changeset, user_changeset: user_changeset} = assigns, socket) do
    {:ok,
    socket
    |> assign(assigns)
    |> assign(:partner_changeset, partner_changeset)
    |> assign(:user_changeset, user_changeset)
    }
  end



end
