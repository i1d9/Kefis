defmodule Kefis.Repo.Migrations.AddWarehouse do
  use Ecto.Migration

  def change do
    create table(:warehouses) do
      add :location_name, :string
      add :lng, :float
      add :lat, :float
      add :user_id, references(:users)

      timestamps()
    end
  end
end
