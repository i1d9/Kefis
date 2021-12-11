defmodule Kefis.Repo.Migrations.AddPartners do
  use Ecto.Migration

  def change do
    create table(:partners) do
      add :name, :string
      add :location, :string
      add :phone, :string
      add :contact_email, :string
      add :contact_phone, :string
      add :lng, :float
      add :lat, :float
      add :type, :string
      add :user_id, references(:users)

      timestamps()
    end
  end
end
