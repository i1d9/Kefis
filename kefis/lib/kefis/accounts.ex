defmodule Kefis.Accounts do
  alias Kefis.Chain.Account
  alias Kefis.Repo
  alias Kefis.Chain.Transaction
  alias Ecto.Changeset

  import Ecto.Query, only: [from: 2]

  def create(user, details) do
    Account.changeset(%Account{}, details)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert!()
  end

  def get_account(partner) do
    query =
      from c in Account,
        preload: [:partner],
        where: c.partner_id == ^partner.id

    Repo.one(query)
  end

  def send(from, to, amount) do
    amount
  end

  def withdraw(%Account{} = account, amount) do
    Transaction.changeset(%Transaction{}, %{amount: amount, type: "withdraw", status: "confirmed"})
    |> Changeset.put_assoc(
      :account,
      Account.changeset(account, %{balance: account.balance - amount})
    )
    |> Repo.insert()
  end

  def deposit(%Account{} = account, amount) do
    Transaction.changeset(%Transaction{}, %{amount: amount, type: "deposit", status: "confirmed"})
    |> Changeset.put_assoc(
      :account,
      Account.changeset(account, %{balance: account.balance + amount})
    )
    |> Repo.insert()
  end
end
