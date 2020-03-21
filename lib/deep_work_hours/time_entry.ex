defmodule DeepWorkHours.TimeEntry do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  schema "time_entries" do
    field :date, :date
    field :start_date_time, :utc_datetime
    field :end_date_time, :utc_datetime
    field :total_time, :time
    field :uid, :string

    timestamps()
  end

  def changeset(entry, params \\ %{}) do
    entry
    |> cast(params, [:start_date_time, :end_date_time])
    |> compare_date_time()
  end

  @doc """
  Compare start and end date time

  ## Examples

      compare_date_time(changeset)

  """
  def compare_date_time(changeset) do
    {_, from_value} = fetch_field(changeset, :start_date_time)
    {_, to_value} = fetch_field(changeset, :end_date_time)

    case DateTime.compare(from_value, to_value) do
      :gt -> add_error(changeset, :start_date_time, "cannot be later than End")
      _ -> changeset
    end
  end
end
