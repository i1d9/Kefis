defmodule Kefis.POS do
  @moduledoc """
  The POS context.
  """

  import Ecto.Query, warn: false
  alias Kefis.Repo

  alias Kefis.POS.Inventory

  @doc """
  Returns the list of inventories.

  ## Examples

      iex> list_inventories()
      [%Inventory{}, ...]

  """
  def list_inventories do
    Repo.all(Inventory)
  end

  @doc """
  Gets a single inventory.

  Raises `Ecto.NoResultsError` if the Inventory does not exist.

  ## Examples

      iex> get_inventory!(123)
      %Inventory{}

      iex> get_inventory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory!(id), do: Repo.get!(Inventory, id)

  @doc """
  Creates a inventory.

  ## Examples

      iex> create_inventory(%{field: value})
      {:ok, %Inventory{}}

      iex> create_inventory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory(attrs \\ %{}) do
    %Inventory{}
    |> Inventory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a inventory.

  ## Examples

      iex> update_inventory(inventory, %{field: new_value})
      {:ok, %Inventory{}}

      iex> update_inventory(inventory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory(%Inventory{} = inventory, attrs) do
    inventory
    |> Inventory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a inventory.

  ## Examples

      iex> delete_inventory(inventory)
      {:ok, %Inventory{}}

      iex> delete_inventory(inventory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory(%Inventory{} = inventory) do
    Repo.delete(inventory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory changes.

  ## Examples

      iex> change_inventory(inventory)
      %Ecto.Changeset{data: %Inventory{}}

  """
  def change_inventory(%Inventory{} = inventory, attrs \\ %{}) do
    Inventory.changeset(inventory, attrs)
  end

  alias Kefis.POS.Sale

  @doc """
  Returns the list of sales.

  ## Examples

      iex> list_sales()
      [%Sale{}, ...]

  """
  def list_sales do
    Repo.all(Sale)
  end

  @doc """
  Gets a single sale.

  Raises `Ecto.NoResultsError` if the Sale does not exist.

  ## Examples

      iex> get_sale!(123)
      %Sale{}

      iex> get_sale!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sale!(id), do: Repo.get!(Sale, id)

  @doc """
  Creates a sale.

  ## Examples

      iex> create_sale(%{field: value})
      {:ok, %Sale{}}

      iex> create_sale(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sale(attrs \\ %{}) do
    %Sale{}
    |> Sale.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sale.

  ## Examples

      iex> update_sale(sale, %{field: new_value})
      {:ok, %Sale{}}

      iex> update_sale(sale, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sale(%Sale{} = sale, attrs) do
    sale
    |> Sale.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sale.

  ## Examples

      iex> delete_sale(sale)
      {:ok, %Sale{}}

      iex> delete_sale(sale)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sale(%Sale{} = sale) do
    Repo.delete(sale)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sale changes.

  ## Examples

      iex> change_sale(sale)
      %Ecto.Changeset{data: %Sale{}}

  """
  def change_sale(%Sale{} = sale, attrs \\ %{}) do
    Sale.changeset(sale, attrs)
  end

  alias Kefis.POS.SaleDetail

  @doc """
  Returns the list of sale_details.

  ## Examples

      iex> list_sale_details()
      [%SaleDetail{}, ...]

  """
  def list_sale_details do
    Repo.all(SaleDetail)
  end

  @doc """
  Gets a single sale_detail.

  Raises `Ecto.NoResultsError` if the Sale detail does not exist.

  ## Examples

      iex> get_sale_detail!(123)
      %SaleDetail{}

      iex> get_sale_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sale_detail!(id), do: Repo.get!(SaleDetail, id)

  @doc """
  Creates a sale_detail.

  ## Examples

      iex> create_sale_detail(%{field: value})
      {:ok, %SaleDetail{}}

      iex> create_sale_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sale_detail(attrs \\ %{}) do
    %SaleDetail{}
    |> SaleDetail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sale_detail.

  ## Examples

      iex> update_sale_detail(sale_detail, %{field: new_value})
      {:ok, %SaleDetail{}}

      iex> update_sale_detail(sale_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sale_detail(%SaleDetail{} = sale_detail, attrs) do
    sale_detail
    |> SaleDetail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sale_detail.

  ## Examples

      iex> delete_sale_detail(sale_detail)
      {:ok, %SaleDetail{}}

      iex> delete_sale_detail(sale_detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sale_detail(%SaleDetail{} = sale_detail) do
    Repo.delete(sale_detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sale_detail changes.

  ## Examples

      iex> change_sale_detail(sale_detail)
      %Ecto.Changeset{data: %SaleDetail{}}

  """
  def change_sale_detail(%SaleDetail{} = sale_detail, attrs \\ %{}) do
    SaleDetail.changeset(sale_detail, attrs)
  end
end
