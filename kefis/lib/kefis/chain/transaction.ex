defmodule Kefis.Chain.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @transaction_types ~w(withdraw deposit send receive)
  @statues_types ~w(pending confirmed failed)

  schema "transactions" do
    field :amount, :integer
    field :status, :string
    field :type, :string
    belongs_to :account, Kefis.Chain.Account

    timestamps()
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :status, :type])
    |> validate_required([:amount, :status, :type])
    |> validate_inclusion(:type, @transaction_types)
  end
end
