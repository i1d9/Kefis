defmodule Kefis.Products do
  alias Kefis.Chain.Product
  alias Kefis.Chain.Partner
  alias Kefis.Repo
  import Ecto.Query, only: [from: 2]

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


end
