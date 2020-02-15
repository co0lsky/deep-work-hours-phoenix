defmodule DeepWorkHours.Repo do
  use Ecto.Repo,
    otp_app: :deep_work_hours,
    adapter: Ecto.Adapters.Postgres
end
