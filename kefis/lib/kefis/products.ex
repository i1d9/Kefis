defmodule Kefis.Products do
  alias Kefis.Chain.Product
  alias Kefis.Chain.Partner
  alias Kefis.Repo
  import Ecto.Query, only: [from: 2]


  def list_products do
    Repo.all(Product)
  end

  def search_product(product_name) do
    query = from p in Product, where: ilike(p.name, ^"%#{product_name}%")
    Repo.all(query)
  end

  def list_partner_products(supplier) do

    IO.inspect(supplier.id)
    query = from po in Product, where: po.partner_id == ^supplier.id
    Repo.all(query)
  end

  def create(supplier, details) do
    supplier
    |> Ecto.build_assoc(:products)
    |> Product.changeset(details)
    |> Repo.insert()
  end

  def update(%Product{} = product, details) do
    details
  end

  def find(id) do
    Repo.get(Product, id)
    |> Repo.preload([:partner])
  end

  def get_by(params) do
    Enum.find Repo.all(Products), fn map ->
        Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  def delete(id) do
    product = Repo.get(Product, id)
    Repo.delete(product)
  end

end
