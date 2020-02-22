defmodule DeepWorkHoursWeb.EntriesListLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  import Ecto.Query

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "entries_list.html", assigns)
  end

  def mount(_params, %{"current_user" => current_user}, socket) do
    entries = DeepWorkHours.Repo.all(
                from(
                  t in DeepWorkHours.TimeEntry,
                  where: t.uid == ^current_user.id,
                  group_by: t.date,
                  order_by: [desc: t.date],
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

    day = entry.day
          |> DeepWorkHoursWeb.DateHelper.human_readable()

    %{day: day, total: total}
  end
end
