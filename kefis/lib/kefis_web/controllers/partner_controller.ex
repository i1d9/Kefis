defmodule KefisWeb.PartnerController do
  use KefisWeb, :controller

  alias Kefis.Chain
  alias Kefis.Chain.Partner

  def index(conn, _params) do
    partners = Chain.list_partners()
    render(conn, "index.html", partners: partners)
  end

  def new(conn, _params) do
    changeset = Chain.change_partner(%Partner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"partner" => partner_params}) do
    case Chain.create_partner(partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner created successfully.")
        |> redirect(to: Routes.partner_path(conn, :show, partner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    render(conn, "show.html", partner: partner)
  end

  def edit(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    changeset = Chain.change_partner(partner)
    render(conn, "edit.html", partner: partner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "partner" => partner_params}) do
    partner = Chain.get_partner!(id)

    case Chain.update_partner(partner, partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner updated successfully.")
        |> redirect(to: Routes.partner_path(conn, :show, partner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", partner: partner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    partner = Chain.get_partner!(id)
    {:ok, _partner} = Chain.delete_partner(partner)

    conn
    |> put_flash(:info, "Partner deleted successfully.")
    |> redirect(to: Routes.partner_path(conn, :index))
  end



  def new_partner_user(conn, _opts) do

  end

  def create_partner_user(%{"user_params" => user_params}) do

    if pa do
      
    end

  end

  def show_partner_user(conn, %{"id" => id}) do

  end
end
