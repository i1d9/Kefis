defmodule Kefis.Chain.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  schema "drivers" do
    field :vehicle, :string
    field :trips, :integer, default: 0
    belongs_to :user, Kefis.Users.User
    has_many :dispatches, Kefis.Chain.Dispatch
    has_many :collections, Kefis.Chain.Collection

    timestamps()
  end

  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:vehicle, :trips])
    |> validate_required([:vehicle, :trips])
  end
end
