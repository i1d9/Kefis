defmodule Kefis.Transactions do

  alias Kefis.Chain.Transaction
  alias Kefis.Repo
  import Ecto.Query

  def list_transactions do
    transactions = Repo.all(Transaction)
    transactions
  end


  def get_transaction!(id), do: Repo.get!(Transaction, id)

  def all(_module), do: []

  def get_by(params) do
    Enum.find all(Transaction), fn map ->
        Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  def create(account, details) do

    Transaction.changeset(%Transaction{}, details)
    |> Ecto.Changeset.put_assoc(:account, account)
    |> Repo.insert!()

  end


end
