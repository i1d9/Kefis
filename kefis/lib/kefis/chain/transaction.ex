defmodule Kefis.Chain.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @transaction_types ~w(withdraw deposit send receive)

  schema "transactions" do
    field :amount, :integer
    field :status, :string
    field :type, :string
    belongs_to :accounts, Kefis.Chain.Account
    
    timestamps()
  end
end
