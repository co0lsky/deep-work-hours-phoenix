defmodule DeepWorkHoursWeb.Router do
  use DeepWorkHoursWeb, :router

  require Ueberauth

  import DeepWorkHoursWeb.AuthPlug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug DeepWorkHoursWeb.AuthPlug
  end

  pipeline :landing do
    plug :put_layout, {DeepWorkHoursWeb.LayoutView, "landing.html"}
  end

  scope "/auth", DeepWorkHoursWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  scope "/landing", DeepWorkHoursWeb do
    pipe_through [:browser, :landing]

    get "/", LandingController, :index
  end

  scope "/", DeepWorkHoursWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index
    get "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", DeepWorkHoursWeb do
  #   pipe_through :api
  # end
end
