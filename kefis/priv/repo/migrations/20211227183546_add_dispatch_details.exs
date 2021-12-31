defmodule Kefis.Repo.Migrations.AddDispatchDetails do
  use Ecto.Migration

  def change do
    create table(:dispatch_details) do
      add :collection_id, references(:collections)
      add :dispatch_id, references(:dispatches)

      timestamps()
    end
  end
end
