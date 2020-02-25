defmodule DeepWorkHoursWeb.DateHelper do
  @moduledoc false

  def human_readable(date) do
    today = Date.utc_today

    day_diff = Date.diff(today, date)

    to_human_readable day_diff, date
  end

  defp to_human_readable(0, _), do: "Today"
  defp to_human_readable(1, _), do: "Yesterday"
  defp to_human_readable(_, date),
       do: Timex.Format.DateTime.Formatter.format(
             date,
             "%a, %d %b",
             Timex.Format.DateTime.Formatters.Strftime)
           |> elem(1)
end
