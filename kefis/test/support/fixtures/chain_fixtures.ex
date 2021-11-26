defmodule Kefis.ChainFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kefis.Chain` context.
  """

  @doc """
  Generate a supplier.
  """
  def supplier_fixture(attrs \\ %{}) do
    {:ok, supplier} =
      attrs
      |> Enum.into(%{
        contact_email: "some contact_email",
        contact_phone: "some contact_phone",
        lat: 120.5,
        lng: 120.5,
        location: "some location",
        name: "some name",
        phone: "some phone"
      })
      |> Kefis.Chain.create_supplier()

    supplier
  end

  @doc """
  Generate a partner.
  """
  def partner_fixture(attrs \\ %{}) do
    {:ok, partner} =
      attrs
      |> Enum.into(%{
        contact_email: "some contact_email",
        contact_phone: "some contact_phone",
        lat: 120.5,
        lng: 120.5,
        location: "some location",
        name: "some name",
        phone: "some phone",
        type: "some type"
      })
      |> Kefis.Chain.create_partner()

    partner
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        category: "some category",
        image: "some image",
        name: "some name",
        price: 42,
        sku: "some sku"
      })
      |> Kefis.Chain.create_product()

    product
  end
end
