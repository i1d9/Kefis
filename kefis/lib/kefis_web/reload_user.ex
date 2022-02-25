defmodule KefisWeb.ReloadUser do
  @moduledoc """
  This module makes all user relationships avalible in the connection struct
  """

  alias Kefis.Repo
  alias Kefis.Users.User



  @spec init(any()) :: any()
  def init(opts), do: opts

  @doc false
  @spec call(Conn.t(), atom()) :: Conn.t()
  def call(conn, _opts) do
    config = Pow.Plug.fetch_config(conn)

    case Pow.Plug.current_user(conn, config) do
      nil ->
        conn

      user ->
        reloaded_user = Repo.get!(User, user.id) |> Repo.preload([:driver, :partner, :account])
        Pow.Plug.assign_current_user(conn, reloaded_user, config)

        
    end
  end
end
