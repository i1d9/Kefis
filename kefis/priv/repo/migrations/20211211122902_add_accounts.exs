defmodule Kefis.Repo.Migrations.AddAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :user_id, references(:users)
      add :balance, :integer
      add :status, :string

      timestamps()
    end
  end
end
