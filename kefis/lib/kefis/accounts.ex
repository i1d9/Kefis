defmodule Kefis.Accounts do

  alias Kefis.Chain.Account
  alias Kefis.Repo
  alias Kefis.Chain.Transaction
  alias Ecto.Changeset

  def create(user,details) do
    Account.changeset(%Account{}, details)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert!()
  end


  def deposit(%Account{} = account, amount) do
    Account.changeset(account, %{balance: account.balance + amount})
    |> Repo.update()
  end

  def send(from, to, amount) do
    amount
  end

  def withdraw(%Account{} = account, amount) do
    Account.changeset(account, %{balance: account.balance - amount})
    |> Repo.update()
  end

  def transact(account, type, amount, details) do
    Transaction.changeset(%Transaction{}, details)
    |> Changeset.put_assoc(:account, account)
    |> Repo.insert!()
  end


end
