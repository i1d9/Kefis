defmodule Kefis.Chain do
  @moduledoc """
  The Chain context.
  """

  import Ecto.Query, warn: false
  alias Kefis.Repo

  alias Kefis.Chain.Supplier

  @doc """
  Returns the list of suppliers.

  ## Examples

      iex> list_suppliers()
      [%Supplier{}, ...]

  """
  def list_suppliers do
    Repo.all(Supplier)
  end

  @doc """
  Gets a single supplier.

  Raises `Ecto.NoResultsError` if the Supplier does not exist.

  ## Examples

      iex> get_supplier!(123)
      %Supplier{}

      iex> get_supplier!(456)
      ** (Ecto.NoResultsError)

  """
  def get_supplier!(id), do: Repo.get!(Supplier, id)

  @doc """
  Creates a supplier.

  ## Examples

      iex> create_supplier(%{field: value})
      {:ok, %Supplier{}}

      iex> create_supplier(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_supplier(attrs \\ %{}) do
    %Supplier{}
    |> Supplier.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a supplier.

  ## Examples

      iex> update_supplier(supplier, %{field: new_value})
      {:ok, %Supplier{}}

      iex> update_supplier(supplier, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_supplier(%Supplier{} = supplier, attrs) do
    supplier
    |> Supplier.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a supplier.

  ## Examples

      iex> delete_supplier(supplier)
      {:ok, %Supplier{}}

      iex> delete_supplier(supplier)
      {:error, %Ecto.Changeset{}}

  """
  def delete_supplier(%Supplier{} = supplier) do
    Repo.delete(supplier)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking supplier changes.

  ## Examples

      iex> change_supplier(supplier)
      %Ecto.Changeset{data: %Supplier{}}

  """
  def change_supplier(%Supplier{} = supplier, attrs \\ %{}) do
    Supplier.changeset(supplier, attrs)
  end

  alias Kefis.Chain.Partner

  @doc """
  Returns the list of partners.

  ## Examples

      iex> list_partners()
      [%Partner{}, ...]

  """
  def list_partners do
    Repo.all(Partner)
  end

  @doc """
  Gets a single partner.

  Raises `Ecto.NoResultsError` if the Partner does not exist.

  ## Examples

      iex> get_partner!(123)
      %Partner{}

      iex> get_partner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_partner!(id), do: Repo.get!(Partner, id)

  @doc """
  Creates a partner.

  ## Examples

      iex> create_partner(%{field: value})
      {:ok, %Partner{}}

      iex> create_partner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partner(attrs \\ %{}) do
    %Partner{}
    |> Partner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partner.

  ## Examples

      iex> update_partner(partner, %{field: new_value})
      {:ok, %Partner{}}

      iex> update_partner(partner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_partner(%Partner{} = partner, attrs) do
    partner
    |> Partner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a partner.

  ## Examples

      iex> delete_partner(partner)
      {:ok, %Partner{}}

      iex> delete_partner(partner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_partner(%Partner{} = partner) do
    Repo.delete(partner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partner changes.

  ## Examples

      iex> change_partner(partner)
      %Ecto.Changeset{data: %Partner{}}

  """
  def change_partner(%Partner{} = partner, attrs \\ %{}) do
    Partner.changeset(partner, attrs)
  end
end
