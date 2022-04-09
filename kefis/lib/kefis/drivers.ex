defmodule Kefis.Drivers do
  alias Kefis.Chain.Driver
  alias Kefis.Repo
  alias Kefis.Users.User
  alias Ecto.Changeset
  alias Kefis.Chain.Collection
  alias Kefis.Chain.Dispatch
  import Ecto.Query, only: [from: 2]

  def create_driver(details) do
    if Driver.changeset(%Driver{}, details).valid? do
      {:ok, details}
    else
      driver_changeset = Driver.changeset(%Driver{}, details)
      {:error, driver_changeset}
    end
  end

  def create_driver_user(driver_details, user_details) do

    user_changeset = User.admin_changeset(%User{}, user_details)
    driver_changeset = Driver.changeset(%Driver{}, driver_details)

    IO.inspect(user_details)
    IO.inspect(user_changeset)

    user_changeset
    |> Changeset.put_assoc(:driver, driver_changeset)
    |> Repo.insert()
  end


  def admin_load_driver do
    Repo.all(Driver) |> Repo.preload([:user])
  end

  def get(id) do
    Repo.get Driver, id
  end


  def driver_collection(driver) do
    query = from c in Collection, preload: [order_detail: [:partner, :product]], where: c.driver_id == ^driver.id
    Repo.all query
  end


  def driver_deliveries(driver) do
    query = from d in Dispatch, preload: [:warehouse, order: [:partner]], where: d.driver_id == ^driver.id
    Repo.all query
  end


end
