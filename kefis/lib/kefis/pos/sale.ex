defmodule Kefis.POS.Sale do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sales" do
    field :sale_date, :date
    field :transaction_id, :id
    field :partner_id, :id

    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:sale_date])
    |> validate_required([:sale_date])
  end
end
