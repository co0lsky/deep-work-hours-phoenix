defmodule DeepWorkHoursWeb.Factory do
    @moduledoc """
    Factory to prepare test data
    """

    alias DeepWorkHours.Repo

    # Factories

    def build(:entry) do
        now_date_time = DateTime.utc_now()
        start_date_time = now_date_time |> DateTime.add((-25 * 60), :second) |> DateTime.truncate(:second)
        end_date_time = now_date_time |> DateTime.truncate(:second)

      %DeepWorkHours.TimeEntry{
        date: Date.utc_today(),
        start_date_time: start_date_time,
        end_date_time: end_date_time,
        total_time: ~T[00:00:00] |> Time.add(DateTime.diff(end_date_time, start_date_time)) |>  Time.truncate(:second),
        uid: "1"
      }
    end

    # Convenience API

    def build(factory_name, attributes) do
      factory_name |> build() |> struct(attributes)
    end

    def insert!(factory_name, attributes \\ []) do
      Repo.insert! build(factory_name, attributes)
    end
end
