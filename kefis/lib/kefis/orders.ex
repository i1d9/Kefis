defmodule Kefis.Orders do

  alias Kefis.Chain.{Order, OrderDetail}
  alias Kefis.Repo
  import Ecto.Query, only: [from: 2]


  def get_order(id), do: Repo.get(Order, id) |> Repo.preload([order_details: [:product, :partner]])

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

  def retailer_new_order(order_info, user, selected_product_changesets) do
      Order.changeset(%Order{}, order_info)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:order_details, selected_product_changesets)
      |> Ecto.Changeset.put_assoc(:partner, user.partner)
      |> Repo.insert()
  end



  def supplier_orders(supplier, status \\ "initiated") do
    query = from ord in OrderDetail, join: p in assoc(ord, :partner), preload: :product, where: p.id == ^supplier.id, where: ord.status == ^status
    Repo.all(query)
  end




  def supplier_order_detail(id, supplier) do
    query = from ord in OrderDetail, join: p in assoc(ord, :partner), preload: [:product, order: [:partner]], where: p.id == ^supplier.id, where: ord.id == ^id
    Repo.one query
  end

  def get_order_details(id), do: Repo.get(OrderDetail, id) |> Repo.preload([:order, :partner, :product  ])

  def update_order_detail(%OrderDetail{} = order_detail, details) do
    order_detail
    |> OrderDetail.changeset(details)
    |> Repo.update()
  end

  def admin_list_orders do
    Repo.all(Order) |> Repo.preload(:partner)
  end

  def admin_show_order(id) do
    Repo.get(Order, id) |> Repo.preload([:partner, order_details: [:product, :partner]])
  end

end
