defmodule Kefis.Repo.Migrations.AddTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :type, :string
      add :status, :string
      add :account_id, references(:accounts)
      add :date, :date
      timestamps()
    end
  end
end
