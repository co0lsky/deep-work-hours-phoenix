defmodule DeepWorkHours.TimeEntry do
  use Ecto.Schema

  schema "time_entries" do
    field :start_date_time, :utc_datetime
    field :end_date_time, :utc_datetime
    field :total_time, :time

    timestamps()
  end

end
