defmodule Teiserver.Tachyon.Schema do
  @moduledoc """

  """

  @spec load_schemas :: list
  def load_schemas() do
    Application.get_env(:central, Teiserver)[:tachyon_schema_path]
    |> Path.wildcard()
    |> Enum.map(fn file_path ->
      contents =
        file_path
        |> File.read!()
        |> Jason.decode!()

      command =
        file_path
        |> Path.split()
        |> Enum.reverse()
        |> Enum.take(3)
        |> Enum.reverse()
        |> Enum.join("/")
        |> String.replace(".json", "")

      schema = JsonXema.new(contents)

      Central.store_put(:tachyon_schemas, command, schema)
      command
    end)
  end

  @spec validate!(map) :: :ok
  def validate!(%{"command" => command} = object) do
    schema = get_schema(command)
    JsonXema.validate!(schema, object)
  end

  defp get_schema(command) do
    ConCache.get(:tachyon_schemas, command)
  end
end
