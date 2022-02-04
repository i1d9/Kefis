defmodule KefisWeb.UserController do
  use KefisWeb, :controller

  alias Kefis.Users.User

  def index(conn, _params)do

  end

  def new(conn, _params) do
    changeset = User.admin_changeset(%User{}, {})
    
  end


  def create(conn, %{"user" => user_params}) do

  end
end
