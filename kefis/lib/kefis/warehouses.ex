defmodule Kefis.Warehouses do
  alias Kefis.Chain.Warehouse
  alias Kefis.Chain.Collection
  alias Kefis.Repo
  import Ecto.Query, only: [from: 2]

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
    Repo.get(Warehouse, id)
  end

  def incoming_orders(warehouse) do
    query =
      from c in Collection,
        where: c.warehouse_id == ^warehouse.id,
        preload: [driver: [:user]],
        where: c.status == ^"picked"

    Repo.all(query)
  end

  def outgoing_orders(warehouse) do
    query =
      from c in Collection,
        where: c.warehouse_id == ^warehouse.id,
        preload: [driver: [:user]],
        where: c.status == ^"processed"

    Repo.all(query)
  end
end
