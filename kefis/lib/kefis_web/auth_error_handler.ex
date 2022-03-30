defmodule KefisWeb.AuthErrorHandler do
  use KefisWeb, :controller
  alias Plug.Conn

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :not_authenticated) do
    conn
    |> put_flash(:error, "You have to be authenticated first")
    |> redirect(to: Routes.login_path(conn, :new))
    |> halt()
  end

  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, :already_authenticated) do

    IO.inspect(conn)

    conn
    |> put_flash(:error, "You are already authenticated")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
