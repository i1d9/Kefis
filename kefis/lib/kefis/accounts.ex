defmodule Kefis.Accounts do

  alias Kefis.Chain.Account
  alias Kefis.Repo


  def create(user,details) do
    Account.changeset(%Account{}, details)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert!()
  end


  def deposit(%Account{} = account, amount) do
    Account.changeset(account, %{amount: account.balance + amount})
    |> Repo.update()
  end

  def send(from, to, amount) do
    amount
  end

  def withdraw(%Account{} = account, amount) do
    Account.changeset(account, %{amount: account.balance - amount})
    |> Repo.update()
  end


end
