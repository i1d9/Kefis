defmodule Kefis.POSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kefis.POS` context.
  """

  @doc """
  Generate a inventory.
  """
  def inventory_fixture(attrs \\ %{}) do
    {:ok, inventory} =
      attrs
      |> Enum.into(%{
        margin: 42,
        quantity: 42
      })
      |> Kefis.POS.create_inventory()

    inventory
  end

  @doc """
  Generate a sale.
  """
  def sale_fixture(attrs \\ %{}) do
    {:ok, sale} =
      attrs
      |> Enum.into(%{
        sale_date: ~D[2022-05-02]
      })
      |> Kefis.POS.create_sale()

    sale
  end

  @doc """
  Generate a sale_detail.
  """
  def sale_detail_fixture(attrs \\ %{}) do
    {:ok, sale_detail} =
      attrs
      |> Enum.into(%{
        price: 42,
        quantity: 42,
        total: 42
      })
      |> Kefis.POS.create_sale_detail()

    sale_detail
  end
end
