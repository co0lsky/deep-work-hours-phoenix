defmodule DeepWorkHours.TimeEntry do
  use Ecto.Schema

  import Ecto.Changeset

  schema "time_entries" do
    field :date, :date
    field :start_date_time, :utc_datetime
    field :end_date_time, :utc_datetime
    field :total_time, :time
    field :uid, :string

    timestamps()
  end

  def changeset(entry, params \\ %{}) do
    cast(entry, params, [:start_date_time, :end_date_time])
  end

end
