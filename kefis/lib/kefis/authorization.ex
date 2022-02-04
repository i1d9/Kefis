defmodule AuthTasks.Authorization do


  alias __MODULE__

  alias AuthTasks.Tasks.Todo

  @doc """
  Create an Authorization struct

  %Authorization{
    create: %{},
    read: %{},
    update: %{},
    delete: %{},
  }
  """
  defstruct role: nil, create: %{}, read: %{}, update: %{}, delete: %{}


  def can("admin" = role) do
    grant(role)
    |> all(Todo)
  end

  def can("programmer" = role) do
    grant(role)
    |> read(Todo)
  end

  def all(authorization, resource) do
    authorization
    |> create(resource)
    |> read(resource)
    |> update(resource)
    |> delete(resource)
  end

  def grant(role), do: %Authorization{role: role}

  def read(authorization, resource), do: put_action(authorization, :read, resource)

  def create(authorization, resource), do: put_action(authorization, :create, resource)

  def update(authorization, resource), do: put_action(authorization, :update, resource)

  def delete(authorization, resource), do: put_action(authorization, :delete, resource)


  def read?(authorization, resource) do
    Map.get(authorization.read, resource, false)
  end

  def create?(authorization, resource) do
    Map.get(authorization.create, resource, false)
  end

  def update?(authorization, resource) do
    Map.get(authorization.update, resource, false)
  end

  def delete?(authorization, resource) do
    Map.get(authorization.delete, resource, false)
  end

  @doc """
  First Param is the Authorization struct
  Second Param is the Resource which may be a database table
  """
  defp put_action(authorization, action, resource) do
    updated_action =
      authorization
      |> Map.get(action)
      |> Map.put(resource, true)
    Map.put(authorization, action, updated_action)
  end

end
