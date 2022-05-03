defmodule Kefis.Repo.Migrations.CreateSales do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :sale_date, :date
      add :transaction_id, references(:transactions, on_delete: :nothing)
      add :partner_id, references(:partners, on_delete: :nothing)

      timestamps()
    end

    create index(:sales, [:transaction_id])
    create index(:sales, [:partner_id])
  end
end
