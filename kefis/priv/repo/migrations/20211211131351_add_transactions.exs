defmodule Kefis.Repo.Migrations.AddTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :type, :string
      add :status, :string
      add :account, references(:accounts)
      timestamps()
    end
  end
end
