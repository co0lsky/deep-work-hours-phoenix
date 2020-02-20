defmodule DeepWorkHours.Repo.Migrations.CreateTimeEntries do
  use Ecto.Migration

  def change do
    create table(:time_entries) do
      add :date, :date
      add :start_date_time, :utc_datetime
      add :end_date_time, :utc_datetime
      add :total_time, :time

      timestamps()
    end
  end
end
