defmodule KefisWeb.UserController do
  use KefisWeb, :controller

  alias Kefis.Users.User
  alias Kefis.Users

  def index(conn, _params)do
    users = Users.list()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = User.admin_changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset)

  end


  def create(conn, %{"user" => user_params}) do
    case Users.add(user_params) do
      {:ok, user} ->

        IO.inspect(user)
        conn
        |> put_flash(:info, "User Created successfully")
        |> redirect(to: Routes.user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)

    end
  end



  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end
end
