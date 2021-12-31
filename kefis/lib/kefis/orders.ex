defmodule Kefis.Orders do

  alias Kefis.Chain.{Order, OrderDetail}
  alias Kefis.Repo


  def get_order!(id), do: Repo.get!(Order, id)

  def all(_module), do: []

  def get_by(params) do
    Repo.get_by!(Order, params)
  end


  def new(retailer, details) do
      retailer
      |> Ecto.build_assoc(:orders)
      |> Order.changeset(details)
      |> Repo.insert!()
  end

  def add_details(order, product, supplier, details) do
    OrderDetail.changeset(%OrderDetail{}, details)
    |> Ecto.Changeset.put_assoc(:product, product)
    |> Ecto.Changeset.put_assoc( :partner, supplier)
    |> Ecto.Changeset.put_assoc( :order, order)
    |> Repo.insert!()
  end

  def update(%Order{} = order, details) do
    order
    |> Order.changeset(details)
    |> Repo.update()
  end

  def delete(%Order{} = order) do
    Repo.delete(order)
  end

  def update_detail(%OrderDetail{} = order_detail, detail) do
    order_detail
    |> OrderDetail.changeset(detail)
    |> Repo.update()
  end

  def delete_detail(%OrderDetail{} = order_detail) do
    Repo.delete(order_detail)
  end

end
