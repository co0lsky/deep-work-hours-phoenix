defmodule DeepWorkHoursWeb.EntriesListLive do
  @moduledoc false

  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "entries_list.html", assigns)
  end

  def mount(_params, %{"current_user" => current_user}, socket) do
    entries =
      DeepWorkHours.get_entries_for_user(current_user)
      |> Enum.map(fn entry -> transform(entry) end)

    {:ok, socket |> assign(:entries, entries)}
  end

  defp transform(entry) do
    total =
      entry.total
      |> Time.truncate(:second)

    day =
      entry.day
      |> DeepWorkHoursWeb.DateHelper.human_readable()

    %{id: entry.id, day: day, total: total}
  end
end
