defmodule Kefis.Collections do

  alias Kefis.Chain.Collection
  alias Kefis.Repo

  def create_collection(_order_detail, collection_details, driver) do

    collection_changeset = Collection.changeset(%Collection{}, collection_details)
    |> Ecto.Changeset.put_assoc(:driver, driver)
    |> Repo.insert!()

  end


  def new(collection) do
    Repo.insert(collection)
  end

end
