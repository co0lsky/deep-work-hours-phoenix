defmodule DeepWorkHoursWeb.PageControllerTest do
  use DeepWorkHoursWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert redirected_to(conn, 302) == "/auth/auth0"
  end
end
