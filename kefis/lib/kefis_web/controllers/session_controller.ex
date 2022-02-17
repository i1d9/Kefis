defmodule KefisWeb.SessionController do
  use KefisWeb, :controller
  alias Kefis.Repo
  alias Kefis.Users.User
  alias KefisWeb.Auth

  def new(conn, _params) do
    changeset = Pow.Plug.change_user(conn)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, conn} ->

        config        = Pow.Plug.fetch_config(conn)
        user          = Pow.Plug.current_user(conn, config)
        reloaded_user = Repo.get!(User, user.id) |> Repo.preload([:driver, :partner, :account])
        Pow.Plug.assign_current_user(conn, reloaded_user, config)

        conn
        |> Pow.Plug.assign_current_user(reloaded_user, config)
        |> put_flash(:info, "Welcome back!")
        |> Auth.landing_page(reloaded_user)

      {:error, conn} ->
        changeset = Pow.Plug.change_user(conn, conn.params["user"])

        conn
        |> put_flash(:info, "Invalid email or password")
        |> render("new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
