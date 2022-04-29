defmodule Kefis.Collections do
  alias Kefis.Chain.Collection
  alias Kefis.Repo
  import Ecto.Query, only: [from: 2]


  def create_collection(_order_detail, collection_details, driver) do
    collection_changeset =
      Collection.changeset(%Collection{}, collection_details)
      |> Ecto.Changeset.put_assoc(:driver, driver)
      |> Repo.insert!()
  end

  def new(collection) do
    Repo.insert(collection)
  end

  def driver_get(id) do
    query =
      from c in Collection,
        preload: [:partner, :warehouse, order_detail: [:partner, :product]],
        where: c.id == ^id

    Repo.one(query)
  end

  def update(%Collection{} = collection, attrs) do
    collection
    |> Collection.changeset(attrs)
    |> Repo.update()
  end

end
