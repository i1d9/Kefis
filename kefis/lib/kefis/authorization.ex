defmodule Kefis.Authorization do


  alias __MODULE__

  alias Kefis.Users.User
  alias Kefis.Chain.Account
  alias Kefis.Chain.Order
  alias Kefis.Chain.Partner
  alias Kefis.Chain.Product
  alias Kefis.Chain.Transaction
  alias Kefis.Chain.Driver
  alias Kefis.Chain.OrderDetail
  alias Kefis.Chain.Collection
  alias Kefis.Chain.Warehouse


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


  def can("super" = role) do
    grant(role)
    |> all(Account)
    |> all(Warehouse)
    |> all(Collection)
    |> all(Order)
    |> all(OrderDetail)
    |> all(Partner)
    |> all(Transaction)
    |> all(Product)
    |> all(User)
  end


  def can("supplier_admin" = role) do
    grant(role)
    |> read(Account)
    |> read(Warehouse)
    |> read(Collection)
    |> read(Order)
    |> read(OrderDetail)
    |> all(Product)
    |> all(User)
  end

  def can("supplier_user" = role) do
    grant(role)
    |> read(Account)
    |> read(Warehouse)
    |> read(Collection)
    |> read(Order)
    |> read(OrderDetail)
    |> read(Product)
    |> all(User)
  end


  def can("retailer_admin" = role) do
    grant(role)
    |> read(Account)
    |> read(Warehouse)
    |> read(Collection)
    |> all(Order)
    |> all(OrderDetail)
    |> read(Product)
    |> all(User)
  end

  def can("retailer_user" = role) do
    grant(role)
    |> read(Account)
    |> read(Warehouse)
    |> read(Collection)
    |> read(Order)
    |> read(OrderDetail)
    |> read(Product)
    |> all(User)
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
