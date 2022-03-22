defmodule KefisWeb.AdminView do
  use KefisWeb, :view

  def render("list_partners.json", %{partners: partners}) do
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
      contact_email: partner.contact_email
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
      contact_email: partner.contact_email,
      products: render_many(partner.products, __MODULE__, "product.json", as: :product)
    }
  end


  def render("product.json", %{product: product}) do
    %{
      price: product.price,
      id: product.id,
      name: product.name,
      sku: product.sku,
      image: product.image,
    }
  end

end
