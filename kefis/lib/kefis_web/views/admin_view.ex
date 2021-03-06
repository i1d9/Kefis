defmodule KefisWeb.AdminView do
  use KefisWeb, :view

  def render("partners.json", %{partners: partners}) do
    %{data: render_many(partners, __MODULE__, "partner.json", as: :partner)}
  end

  def render("show.json", %{partner: partner}) do
    %{data: render_one(partner, __MODULE__, "partner.json", as: :partner)}
  end

  def render("partner.json", %{partner: partner}) do
    %{
      type: partner.type,
      id: partner.id,
      name: partner.name,
      phone: partner.phone,
      lat: partner.lat,
      lng: partner.lng,
      email: partner.email
    }
  end

  def render("admin_partner.json", %{partner: partner}) do
    %{
      type: partner.type,
      id: partner.id,
      name: partner.name,
      phone: partner.phone,
      lat: partner.lat,
      lng: partner.lng,
      email: partner.email,
      user: render_one(partner.user, __MODULE__, "user.json", as: :user)
    }
  end

  def render("partner_w_products.json", %{partner: partner}) do
    %{
      type: partner.type,
      id: partner.id,
      name: partner.name,
      phone: partner.phone,
      lat: partner.lat,
      lng: partner.lng,
      email: partner.email,
      products: render_many(partner.products, __MODULE__, "product.json", as: :product)
    }
  end

  def render("product.json", %{product: product}) do
    %{
      price: product.price,
      id: product.id,
      name: product.name,
      sku: product.sku,
      image: product.image
    }
  end

  def render("orders.json", %{orders: orders}) do
    %{data: render_many(orders, __MODULE__, "basic_order.json", as: :order)}
  end

  def render("basic_order.json", %{order: order}) do
    %{
      id: order.id,
      value: order.value,
      status: order.status,
      ordered_by: render_one(order.partner, __MODULE__, "partner.json", as: :partner)
    }
  end

  def render("order.json", %{order: order}) do
    %{
      id: order.id,
      value: order.value,
      status: order.status,
      ordered_by: render_one(order.partner, __MODULE__, "partner.json", as: :partner),
      details:
        render_many(order.order_details, __MODULE__, "order_detail.json", as: :order_detail)
    }
  end

  def render("order_detail.json", %{order_detail: order_detail}) do
    %{
      id: order_detail.id,
      price: order_detail.price,
      quantity: order_detail.quantity,
      supplied_by: render_one(order_detail.partner, __MODULE__, "partner.json", as: :partner),
      product: render_one(order_detail.product, __MODULE__, "product.json", as: :product)
    }
  end

  def render("user.json", %{user: user}) do
    %{
      email: user.email,
      second_name: user.second_name,
      first_name: user.first_name,
      role: user.role,
      phone: user.phone,
      id: user.id
    }
  end
end
