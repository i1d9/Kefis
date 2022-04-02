defmodule Kefis.Warehouses do

  alias Kefis.Chain.Warehouse
  alias Kefis.Repo

  def list() do
    warehouses = Repo.all(Warehouse)
    warehouses
  end

  def create(details) do
    %Warehouse{}
    |> Warehouse.changeset(details)
    |> Repo.insert()
  end


  def delete(%Warehouse{} = warehouse) do
    Repo.delete(warehouse)
  end


  def update(%Warehouse{} = warehouse, details) do
    warehouse
    |> Warehouse.changeset(details)
    |> Repo.update()
  end

  def show(id) do
    Repo.get Warehouse, id
  end
end
