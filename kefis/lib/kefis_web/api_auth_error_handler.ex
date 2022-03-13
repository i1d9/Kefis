defmodule KefisWeb.ApiAuthErrorHandler do
  use KefisWeb, :controller
  alias Plug.Conn


  def call(conn, :not_authenicated) do
    conn
    |> put_status(401)
    |> json(%{error: %{code: 401, message: "Not Authenticated"}})
  end
end
