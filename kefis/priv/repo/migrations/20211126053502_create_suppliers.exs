defmodule Kefis.Repo.Migrations.CreateSuppliers do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :location, :string
      add :phone, :string
      add :contact_email, :string
      add :lng, :float
      add :lat, :float

      timestamps()
    end
  end
end
