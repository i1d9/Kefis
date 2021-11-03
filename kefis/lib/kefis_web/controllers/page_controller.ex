defmodule KefisWeb.PageController do
  use KefisWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
