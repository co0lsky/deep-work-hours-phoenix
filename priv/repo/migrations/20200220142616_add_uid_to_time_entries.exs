defmodule DeepWorkHours.Repo.Migrations.AddUidToTimeEntries do
  use Ecto.Migration

  def change do
    alter table("time_entries") do
      add :uid, :string
    end
  end
end
