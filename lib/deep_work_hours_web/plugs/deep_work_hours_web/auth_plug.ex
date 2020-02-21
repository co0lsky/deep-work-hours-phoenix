defmodule DeepWorkHoursWeb.AuthPlug do
  @moduledoc """
  Plug to make sure user is authenticated.
  """

  import Plug.Conn
  import Phoenix.Controller

  def init(default), do: default

  def call(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
      nil ->
        conn
        |> redirect(to: "/auth/auth0")
        |> halt
      _ ->
        conn
        |> assign(:current_user, user)
    end
  end
end
