defmodule DeepWorkHours.TimeEntryTest do
  use DeepWorkHours.DataCase, async: true

  alias DeepWorkHours.TimeEntry

  test "end date time cannot earlier than start date time" do
    changeset =
      TimeEntry.changeset(%TimeEntry{}, %{
        "start_date_time" => %{
          "day" => "5",
          "hour" => "23",
          "minute" => "17",
          "month" => "3",
          "year" => "2020"
        },
        "end_date_time" => %{
          "day" => "5",
          "hour" => "23",
          "minute" => "16",
          "month" => "3",
          "year" => "2020"
        }
      })

    refute changeset.valid?
  end
end
