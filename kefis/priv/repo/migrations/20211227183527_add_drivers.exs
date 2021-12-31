defmodule Kefis.Repo.Migrations.AddDrivers do
  use Ecto.Migration

  def change do
    create table(:drivers) do
      add :vehicle, :string
      add :trips, :integer
      add :user_id, references(:users)

      timestamps()
    end

  end
end
