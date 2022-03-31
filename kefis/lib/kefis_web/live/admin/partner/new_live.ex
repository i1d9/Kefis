defmodule KefisWeb.Admin.Partner.NewLive do
  use KefisWeb, :live_view

  alias Kefis.Chain.Partner
  alias Kefis.Chain
  alias Kefis.Users.User

  def mount(_params, _session, socket) do
    partner_changeset = Chain.change_partner(%Partner{})
    user_changeset = User.admin_changeset(%User{}, %{})

    {
      :ok,
      socket
      |> assign(:partner_changeset, partner_changeset)
      |> assign(:user_changeset, user_changeset)
      |> assign(:partner_details_valid, false)
      |> assign(:user_form_visible, false)
    }
  end

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





  def handle_event("partner_save", %{"partner" => _partner_params}, socket) do
    {:noreply, socket}
  end


  def handle_event("user_save", %{"user" => _user_params}, socket) do
    IO.inspect(socket)
    {:noreply, socket}
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

    changeset =
      Chain.change_partner(%Partner{}, partner_params)
      |> Map.put(:action, :validate)
    {:noreply,
    socket
    |> assign(:partner_changeset, changeset)
    |> assign(:partner_details_valid, changeset.valid?)
    }
  end


  def handle_info({:updated_map_component, %{coordinate: %{"lat" => lat, "lng" => lng}}}, socket) do

    {:noreply,
    socket
    |> assign(map_lat: lat, map_lng: lng)
    }
  end




end
