defmodule Kefis.Drivers do
  alias Kefis.Chain.Driver
  alias Kefis.Repo
  alias Kefis.Users.User
  alias Ecto.Changeset

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


end
