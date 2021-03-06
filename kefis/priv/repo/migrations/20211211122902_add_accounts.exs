defmodule Kefis.Repo.Migrations.AddAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :partner_id, references(:partners)
      add :balance, :integer
      add :status, :string

      timestamps()
    end
  end
  
end
