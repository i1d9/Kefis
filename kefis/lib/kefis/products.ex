defmodule Kefis.Products do
  alias Kefis.Chain.Product
  alias Kefis.Repo


  def list_partner_products(supplier) do
    Repo.all(Product)
  end
  
  def create(supplier, details) do
    supplier
    |> Ecto.build_assoc(:products)
    |> Product.changeset(details)
    |> Repo.insert!()
  end

  def update(%Product{} = product, details) do
    details
  end


end
