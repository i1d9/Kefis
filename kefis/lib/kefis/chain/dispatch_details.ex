defmodule Kefis.Chain.DispatchDetails do
  use Ecto.Schema
  #import Ecto.Changeset

  schema "dispatch_details" do

    belongs_to :collection, Kefis.Chain.Collection
    belongs_to :dispatch, Kefis.Chain.Dispatch

  end


end
