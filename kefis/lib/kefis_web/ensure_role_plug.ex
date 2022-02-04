defmodule KefisWeb.EnsureRolePlug do

  @moduledoc """
  This plug ensure that a user has particular role

  ## Example

    plug KefisWeb.EnsureRolePlug, [:user, :admin]

    plug KefisWeb.EnsureRolePlug, :admin

  """

  import Plug.Conn, only: [halt: 1]

  alias KefisWeb.Router.Helpers, as: Routes
  alias Phoenix.Controller
  alias Plug.Conn
  alias Pow.Plug

  @doc false
  @spec init(any()) :: any()
  def init(config), do: config

  @doc false

  @spec call(Conn.t(), atom() | binary() | [atom()] | [binary()]) :: Conn.t()
  def call(conn, roles) do
    conn
    |> Plug.current_user()
    |> has_role?(roles)
    |> maybe_halt(conn)
  end

  defp has_role?(nil, _roles) do
    
  end
end
