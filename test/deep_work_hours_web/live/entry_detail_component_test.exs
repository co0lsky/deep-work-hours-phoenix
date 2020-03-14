defmodule DeepWorkHoursWeb.Components.EntryDetailComponentTest do
    use DeepWorkHoursWeb.ConnCase, async: true

    import Phoenix.LiveViewTest
    import DeepWorkHoursWeb.Factory

    test "render component", %{conn: _conn} do
        entry = insert!(:entry)

        assert render_component(
            DeepWorkHoursWeb.Components.EntryDetailComponent,
            id: entry.id) =~ "detail-#{entry.id}"
    end

    test "toggle detail form", %{conn: conn} do
        entry = insert!(:entry)

        {:ok, view, _html} =
            live_isolated(conn, DeepWorkHoursWeb.EntriesListLive, session: %{"current_user" => %{id: "1"}})

        # Show detail
        assert render_click([view, "detail-#{entry.id}"], "toggle", %{}) =~ "Time Entry Details"

        # Hide detail
        refute render_click([view, "detail-#{entry.id}"], "toggle", %{}) =~ "Time Entry Details"
    end

    test "save time entry", %{conn: conn} do
        entry = insert!(:entry)

        {:ok, view, _html} =
            live_isolated(conn, DeepWorkHoursWeb.EntriesListLive, session: %{"current_user" => %{id: "1"}})

        # Submit form
        render_submit([view, "detail-#{entry.id}"], "save", %{"time_entry" => %{
            "end_date_time" => %{
              "day" => "5",
              "hour" => "23",
              "minute" => "17",
              "month" => "3",
              "year" => "2020"
            },
            "start_date_time" => %{
              "day" => "5",
              "hour" => "23",
              "minute" => "16",
              "month" => "3",
              "year" => "2020"
            }
          }})

        # Retrieve updated object
        entry = DeepWorkHours.Repo.get!(DeepWorkHours.TimeEntry, entry.id)

        assert entry.start_date_time == DateTime.from_iso8601("2020-03-05 23:16:00Z") |> elem(1)
        assert entry.end_date_time == DateTime.from_iso8601("2020-03-05 23:17:00Z") |> elem(1)
    end
end
