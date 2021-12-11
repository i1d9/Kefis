defmodule Kefis.Chain.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @statuses ~w(locked dormant active)

  schema "accounts" do
    field :balance, :integer
    field :status, :string, default: "active"
    belongs_to :user, Kefis.Users.User
    has_many :transactions, Kefis.Chain.Transaction
    timestamps()
  end

end
