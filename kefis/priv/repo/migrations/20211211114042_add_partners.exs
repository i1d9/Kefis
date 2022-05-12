defmodule Kefis.Repo.Migrations.AddPartners do
  use Ecto.Migration

  def change do
    create table(:partners) do
      add :name, :string
      add :location, :string
      add :phone, :string
      add :email, :string
      add :lng, :float
      add :lat, :float
      add :type, :string
      add :user_id, references(:users)


      timestamps()
    end
  end
end
