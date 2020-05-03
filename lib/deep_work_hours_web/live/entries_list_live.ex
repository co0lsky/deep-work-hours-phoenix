defmodule DeepWorkHoursWeb.EntriesListLive do
  @moduledoc false

  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    Phoenix.View.render(DeepWorkHoursWeb.PageView, "entries_list.html", assigns)
  end

  def mount(_params, %{"current_user" => current_user}, socket) do
    if connected?(socket), do: DeepWorkHours.subscribe()

    entries =
      DeepWorkHours.get_entries_for_user(current_user)
      |> transform_entries

    {:ok, socket |> assign(:entries, entries)}
  end

  defp transform_entries(entries) do
    Enum.map(entries, fn entry -> transform(entry) end)
  end

  # @impl true
  def handle_info({:entry_inserted, entry}, socket) do
    transformed_entry = transform(build_entry(entry))

    {:noreply, update(socket, :entries, fn entries -> [transformed_entry | entries] end)}
  end

  defp build_entry(entry_from_scheme) do
    %{id: entry_from_scheme.id, day: entry_from_scheme.date, total: entry_from_scheme.total_time}
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
