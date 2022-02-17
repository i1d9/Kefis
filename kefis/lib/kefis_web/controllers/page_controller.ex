defmodule KefisWeb.PageController do
  use KefisWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.assigns.current_user)
    render(conn, "index.html")
  end
end
