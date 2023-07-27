defmodule Teiserver.Telemetry.ComplexMatchEventType do
  @moduledoc false
  use CentralWeb, :schema

  schema "telemetry_complex_match_event_types" do
    field :name, :string
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  @spec changeset(Map.t(), Map.t()) :: Ecto.Changeset.t()
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(name)a)
    |> validate_required(~w(name)a)
  end

  @spec authorize(atom, Plug.Conn.t(), Map.t()) :: boolean
  def authorize(_action, conn, _params), do: allow?(conn, "Server")
end
