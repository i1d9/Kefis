defmodule Kefis.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :second_name, :string
      add :phone, :string
      add :email, :string, null: false
      add :password_hash, :string, redact: true
      add :role, :string
      
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
