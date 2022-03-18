defmodule KefisWeb.SessionController do
  use KefisWeb, :controller
  alias Kefis.Repo
  alias Kefis.Users.User
  alias KefisWeb.Auth

  alias KefisWeb.ApiAuth

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
    |> configure_session(renew: true)
    |> clear_session()
    |> redirect(to: Routes.page_path(conn, :index))
  end



  ### API ###
  def api_create(conn, %{"user" => user_params}) do
    IO.inspect(user_params)
    conn
    |> Pow.Plug.authenticate_user(user_params)
    |> case do
      {:ok, conn} ->
        json(conn, %{data: %{access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})

      {:error, conn} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid Credentials"}})
    end
  end

  def api_renew(conn, _params) do
    config = Pow.Plug.fetch_config(conn)

    conn
    |> ApiAuth.renew(config)
    |> case do
      {conn, nil} ->
        conn
        |> put_status(401)
        |> json(%{error: %{status: 401, message: "Invalid token"}})

      {conn, _user} ->
        json(conn, %{data: %{access_token: conn.private.api_access_token, renewal_token: conn.private.api_renewal_token}})
    end
  end

  def api_delete(conn, _params) do
    conn
    |> Pow.Plug.delete()
    |> json(%{data: %{}})
  end

end
