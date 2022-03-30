defmodule Kefis.Users do
  alias Kefis.{Repo, Users.User}

  import Ecto.Query, only: [from: 2]

  @type t :: %User{}

  @spec create_admin(map()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def create_admin(params) do
    %User{}
    |> User.changeset(params)
    |> User.role_changeset(%{role: "admin"})
    |> Repo.insert()
  end

  @spec set_admin_role(t()) :: {:ok, t()} | {:error, Ecto.Changeset.t()}
  def set_admin_role(user) do
    user
    |> User.role_changeset(%{role: "admin"})
    |> Repo.update()
  end


  def add(details)do
    %User{}
    |> User.admin_changeset(details)
    |> Repo.insert()
  end

  def update(%User{} = user, attrs) do
    user
    |> User.admin_changeset(attrs)
    |> Repo.update()
  end


  def delete(%User{} = user) do
    Repo.delete(user)
  end


  def list() do
    Repo.all(User)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def all(_module), do: []

  def get_by(params) do
    Enum.find all(User), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  def get_supplier do
    query = from u in User, where: u.role == "supplier_admin"
    Repo.all query
  end

  def get_retailer do
    query = from u in User, where: u.role == "retailer_admin"
    Repo.all query
  end

end
