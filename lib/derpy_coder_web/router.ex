defmodule DerpyCoderWeb.Router do
  use DerpyCoderWeb, :router

  alias DerpyCoderWeb.EnsureRolePlug

  import DerpyCoderWeb.UserAuth
  import Phoenix.LiveDashboard.Router

  pipeline :user do
    plug EnsureRolePlug, [:admin, :user]
  end

  pipeline :admin do
    plug EnsureRolePlug, :admin
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DerpyCoderWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DerpyCoderWeb do
    pipe_through :browser

    # get "/", PageController, :index
    live "/", HomePageLive, :index

    # Following routes do have authenticated & authorized components, but not the whole page!
    live "/photos", PhotoLive.Index, :index
    live "/photos/new", PhotoLive.Index, :new
    live "/photos/:id", PhotoLive.Show, :show

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", DerpyCoderWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through :browser

  #     live_dashboard "/dashboard", metrics: DerpyCoderWeb.Telemetry
  #   end
  # end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/users", DerpyCoderWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/register", UserRegistrationController, :new
    post "/register", UserRegistrationController, :create
    get "/log_in", UserSessionController, :new
    post "/log_in", UserSessionController, :create
    get "/reset_password", UserResetPasswordController, :new
    post "/reset_password", UserResetPasswordController, :create
    get "/reset_password/:token", UserResetPasswordController, :edit
    put "/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/users", DerpyCoderWeb do
    pipe_through [:browser, :require_authenticated_user, :user]

    get "/settings", UserSettingsController, :edit
    put "/settings", UserSettingsController, :update
    get "/settings/confirm_email/:token", UserSettingsController, :confirm_email
    live "/dashboard", UserDashboardLive, :index
  end

  scope "/", DerpyCoderWeb do
    pipe_through [:browser, :require_authenticated_user, :user]

    # Following 2 Routes are entirely authenticated & authorized!
    live "/photos/:id/edit", PhotoLive.Index, :edit
    live "/photos/:id/show/edit", PhotoLive.Show, :edit
  end

  scope "/admin", DerpyCoderWeb do
    pipe_through [:browser, :require_authenticated_user, :admin]

    live "/dashboard", AdminDashboardLive, :index

    live_dashboard "/live_dashboard", metrics: DerpyCoderWeb.Telemetry, ecto_repos: [DerpyCoder.Repo]
  end
end
