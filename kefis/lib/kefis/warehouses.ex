defmodule Kefis.Warehouses do

  alias Kefis.Chain.Warehouse
  alias Kefis.Repo

  def list() do
    warehouses = Repo.all(Warehouse)
    warehouses
  end

  def create(details) do

  end


  def delete(details) do

  end


  def update(details) do

  end

  def show(id) do
    
  end
end
