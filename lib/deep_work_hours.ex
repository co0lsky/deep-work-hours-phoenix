defmodule DeepWorkHours do
  @moduledoc """
  DeepWorkHours keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import Ecto.Query

  alias DeepWorkHours.{Repo, TimeEntry}

  @repo Repo

  @spec list_entries :: any
  def list_entries do
    @repo.all(TimeEntry)
  end

  @spec get_entry(any) :: any
  def get_entry(id) do
    @repo.get!(TimeEntry, id)
  end

  @spec get_entry_by(any) :: any
  def get_entry_by(attrs) do
    @repo.get_by(TimeEntry, attrs)
  end

  def insert_entry(attrs) do
    TimeEntry
    |> struct(attrs)
    |> @repo.insert()
    |> broadcast(:entry_inserted)
  end

  def delete_entry(%TimeEntry{} = entry), do: @repo.delete(entry)

  def update_entry(%TimeEntry{} = entry, updates) do
    entry
    |> TimeEntry.changeset(updates)
    |> @repo.update()
  end

  def get_entries_for_user(user) do
    query =
      from t in TimeEntry,
        where: t.uid == ^user.id,
        #                  group_by: t.date,
        order_by: [desc: t.id],
        select: %{id: t.id, day: t.date, total: t.total_time}

    @repo.all(query)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(DeepWorkHours.PubSub, "entries")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, entry}, event) do
    Phoenix.PubSub.broadcast(DeepWorkHours.PubSub, "entries", {event, entry})

    {:ok, entry}
  end
end
