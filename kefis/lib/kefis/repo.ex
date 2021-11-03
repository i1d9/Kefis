defmodule Kefis.Repo do
  use Ecto.Repo,
    otp_app: :kefis,
    adapter: Ecto.Adapters.Postgres
end
