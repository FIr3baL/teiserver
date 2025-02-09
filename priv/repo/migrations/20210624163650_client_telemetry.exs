defmodule Teiserver.Repo.Migrations.ClientEvent do
  use Ecto.Migration

  def change do
    create table(:teiserver_telemetry_property_types_cache) do
      add :name, :string
    end

    create table(:teiserver_telemetry_event_types) do
      add :name, :string
    end

    create table(:teiserver_telemetry_unauth_properties, primary_key: false) do
      add :hash, :string, primary_key: true
      add :last_updated, :utc_datetime

      add :property_type_id, references(:teiserver_telemetry_property_types_cache, on_delete: :nothing),
        primary_key: true

      add :value, :string
    end

    create table(:teiserver_telemetry_client_properties, primary_key: false) do
      add :user_id, references(:account_users, on_delete: :nothing), primary_key: true
      add :last_updated, :utc_datetime

      add :property_type_id, references(:teiserver_telemetry_property_types_cache, on_delete: :nothing),
        primary_key: true

      add :value, :string
    end

    create table(:teiserver_telemetry_unauth_events) do
      add :hash, :string
      add :timestamp, :utc_datetime

      add :event_type_id, references(:teiserver_telemetry_event_types, on_delete: :nothing)
      add :value, :jsonb
    end

    create table(:teiserver_telemetry_client_events) do
      add :user_id, references(:account_users, on_delete: :nothing)
      add :timestamp, :utc_datetime

      add :event_type_id, references(:teiserver_telemetry_event_types, on_delete: :nothing)
      add :value, :jsonb
    end
  end
end
