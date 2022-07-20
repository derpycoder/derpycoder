defmodule DerpyCoderWeb.Router do
  use DerpyCoderWeb, :router

  alias DerpyCoderWeb.EnsureRolePlug

  import DerpyCoderWeb.UserAuth
  import Phoenix.LiveDashboard.Router

  pipeline :user do
    plug EnsureRolePlug, [:super_admin, :admin, :super_user, :user]
  end

  pipeline :admin do
    plug EnsureRolePlug, [:super_admin, :admin]
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

    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
    delete "/users/log_out", UserSessionController, :delete
  end

  # ==============================================================================
  # Other scopes may use custom stacks.
  # ==============================================================================
  # scope "/api", DerpyCoderWeb do
  #   pipe_through :api
  # end

  # ==============================================================================
  # Redirect Authenticated Users
  # ==============================================================================
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

  # ==============================================================================
  # Following routes may require Authentication & Authorization on some actions.
  # ==============================================================================
  live_session :visitor, on_mount: {DerpyCoderWeb.CurrentUser, :maybe_required} do
    scope "/", DerpyCoderWeb do
      pipe_through [:browser]

      live "/", HomePageLive, :index

      live "/photos", PhotoLive.Index, :index
      live "/photos/new", PhotoLive.Index, :new
      live "/photos/:id", PhotoLive.Show, :show
    end
  end

  # ==============================================================================
  # Following routes have Authentication as well as Authorization mandatory
  # ==============================================================================
  live_session :user, on_mount: {DerpyCoderWeb.CurrentUser, :user_required} do
    scope "/", DerpyCoderWeb do
      pipe_through [:browser, :require_authenticated_user, :user]

      get "/users/settings", UserSettingsController, :edit
      put "/users/settings", UserSettingsController, :update
      get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

      live "/photos/:id/edit", PhotoLive.Index, :edit
      live "/photos/:id/show/edit", PhotoLive.Show, :edit
    end
  end

  scope "/admin", DerpyCoderWeb do
    pipe_through [:browser, :require_authenticated_user, :admin]

    live_dashboard "/live_dashboard",
      metrics: DerpyCoderWeb.Telemetry,
      ecto_repos: [DerpyCoder.Repo]
  end

  # ==============================================================================
  # Below routes have custom root layout
  # ==============================================================================
  live_session :user_dashboard,
    on_mount: {DerpyCoderWeb.CurrentUser, :user_required},
    root_layout: {DerpyCoderWeb.LayoutView, "user_dashboard.html"} do
    scope "/users", DerpyCoderWeb do
      pipe_through [:browser, :require_authenticated_user, :user]

      live "/dashboard", UserDashboardLive, :index
    end
  end

  live_session :admin_dashboard,
    on_mount: {DerpyCoderWeb.CurrentUser, :admin_required},
    root_layout: {DerpyCoderWeb.LayoutView, "admin_dashboard.html"} do
    scope "/admin", DerpyCoderWeb do
      pipe_through [:browser, :require_authenticated_user, :admin]

      live "/dashboard", AdminDashboardLive, :index
    end
  end

  # ==============================================================================
  # Development Environment Specific Routes
  # ==============================================================================
  # Enables the Swoosh mailbox preview in development.
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
