defmodule DeepWorkHours.FakeRepo do
  alias DeepWorkHours.TimeEntry

  @entries [
    %TimeEntry{
      date: ~D[2020-04-10],
      end_date_time: ~N[2020-04-10 00:25:00],
      id: 1,
      start_date_time: ~N[2020-04-10 00:00:00],
      total_time: ~T[00:25:00],
      uid: 1
    },
    %TimeEntry{
      date: ~D[2020-04-10],
      end_date_time: ~N[2020-04-10 00:50:00],
      id: 2,
      start_date_time: ~N[2020-04-10 00:25:00],
      total_time: ~T[00:25:00],
      uid: 1
    },
    %TimeEntry{
      date: ~D[2020-04-11],
      end_date_time: ~N[2020-04-11 00:50:00],
      id: 3,
      start_date_time: ~N[2020-04-11 00:25:00],
      total_time: ~T[00:25:00],
      uid: 1
    },
    %TimeEntry{
      date: ~D[2020-04-11],
      end_date_time: ~N[2020-04-11 00:50:00],
      id: 4,
      start_date_time: ~N[2020-04-11 00:25:00],
      total_time: ~T[00:25:00],
      uid: 2
    }
  ]

  @spec all(DeepWorkHours.TimeEntry) :: [DeepWorkHours.TimeEntry.t(), ...]
  def all(TimeEntry), do: @entries

  @spec get!(DeepWorkHours.TimeEntry, any) :: any
  def get!(TimeEntry, id) do
    Enum.find(@entries, fn entry -> entry.id === id end)
  end

  def get_by(TimeEntry, attrs) do
    Enum.find(@entries, fn entry ->
      Enum.all?(Map.keys(attrs), fn key ->
        Map.get(entry, key) === attrs[key]
      end)
    end)
  end
end
