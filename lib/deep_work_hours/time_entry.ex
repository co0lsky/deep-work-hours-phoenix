defmodule DeepWorkHours.TimeEntry do
  use Ecto.Schema

  schema "time_entries" do
    field :date, :date
    field :start_date_time, :utc_datetime
    field :end_date_time, :utc_datetime
    field :total_time, :time
    field :uid, :string

    timestamps()
  end

end
