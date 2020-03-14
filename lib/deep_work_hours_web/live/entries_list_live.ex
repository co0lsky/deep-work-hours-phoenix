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
#                  group_by: t.date,
                  order_by: [desc: t.id],
                  select: %{id: t.id, day: t.date, total: t.total_time}
                )
              )
              |> Enum.map(fn entry -> transform entry end)

    {:ok, socket |> assign(:entries, entries)}
  end

  defp transform(entry) do
    total = entry.total
            |> Time.truncate(:second)

    day = entry.day
          |> DeepWorkHoursWeb.DateHelper.human_readable()

    %{id: entry.id, day: day, total: total}
  end
end
