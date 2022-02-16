defmodule KefisWeb.AdminController do

  use KefisWeb, :controller

  def index(conn, _opts) do
    render(conn, "index.html")
  end
end
