defmodule Teiserver.Logging.ServerWeekLog do
  use CentralWeb, :schema

  @primary_key false
  schema "teiserver_server_week_logs" do
    field :year, :integer, primary_key: true
    field :week, :integer, primary_key: true
    field :date, :date
    field :data, :map
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(Map.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(year week date data)a)
    |> validate_required(~w(year week date data)a)
  end

  @spec authorize(atom, Plug.Conn.t(), Map.t()) :: boolean
  def authorize(_action, conn, _params), do: allow?(conn, "Server")
end
