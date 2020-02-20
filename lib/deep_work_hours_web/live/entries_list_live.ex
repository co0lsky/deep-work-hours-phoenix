defmodule DeepWorkHoursWeb.EntriesListLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  import Ecto.Query

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "entries_list.html", assigns)
  end

  def mount(_params, %{}, socket) do
    entries = DeepWorkHours.Repo.all(
                from(
                  t in DeepWorkHours.TimeEntry,
                  group_by: t.date,
                  select: %{day: t.date, total: sum(t.total_time)}
                )
              )
              |> Enum.map(fn entry -> transform entry end)

    {:ok, socket |> assign(:entries, entries)}
  end

  defp transform(entry) do
    total = Time.new(
      entry.total.days * 24,
      div(entry.total.secs, 60),
      rem(entry.total.secs, 60),
      0)
      |> elem(1)
      |> Time.truncate(:second)

    %{day: entry.day, total: total}
  end
end
