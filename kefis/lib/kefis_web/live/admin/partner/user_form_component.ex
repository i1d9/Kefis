defmodule KefisWeb.Admin.Partner.UserFormComponent do
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

  def render(assigns) do
    ~H"""
    <div>
      <.form

              let={user_f} for={@user_changeset}
                  phx-change="user_validate"
              phx-submit="user_save"

              >


      <div class="mb-4">
      <%= label user_f, :first_name, for: "first_name" %>
      <%= text_input user_f, :first_name, class: "form-control", id: "first_name" %>
      <%= error_tag user_f, :first_name %>
      </div>



      <div class="mb-4">
      <%= label user_f, :second_name, for: "second_name" %>
      <%= text_input user_f, :second_name, class: "form-control", id: "second_name" %>
      <%= error_tag user_f, :second_name %>
      </div>


      <div class="mb-4">
      <%= label user_f, :phone, for: "phone" %>
      <%= text_input user_f, :phone, class: "form-control", id: "phone" %>
      <%= error_tag user_f, :phone %>
      </div>


      <div class="mb-4">
      <%= label user_f, :email, for: "email" %>
      <%= text_input user_f, :email, class: "form-control", id: "email" %>
      <%= error_tag user_f, :email %>
      </div>


      <div class="mb-4">
        <%= label user_f, :password, for: "email" %>
      <%= text_input user_f, :password, class: "form-control", id: "password" %>
      <%= error_tag user_f, :password %>
      </div>


      <div class="mb-4">
          <%= label user_f, :password_confirmation, for: "password_confirmation" %>
      <%= text_input user_f, :password_confirmation, class: "form-control", id: "password_confirmation" %>
      <%= error_tag user_f, :password_confirmation %>
    </div>



      <div>
          <button type="button" phx-click="back_page" class="btn btn-success"> Back</button>

        <%= submit "Create Partner", class: "btn btn-success" %>
      </div>

    </.form>

    </div>

    """
  end
end
