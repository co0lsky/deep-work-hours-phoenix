defmodule DeepWorkHoursWeb.DateHelper do
  @moduledoc false

  alias Timex.Format.DateTime.Formatter
  alias Timex.Format.DateTime.Formatters

  def human_readable(date) do
    today = Date.utc_today

    day_diff = Date.diff(today, date)

    to_human_readable day_diff, date
  end

  defp to_human_readable(0, _), do: "Today"
  defp to_human_readable(1, _), do: "Yesterday"
  defp to_human_readable(_, date),
       do: Formatter.format(
             date,
             "%a, %d %b",
             Formatters.Strftime)
           |> elem(1)
end
