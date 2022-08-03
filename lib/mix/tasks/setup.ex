defmodule Mix.Tasks.App.Setup do
  @moduledoc """
  Used to initialize the application.

  command: `mix app.setup super_admin`
  """
  @shortdoc "Used to initialize the application"

  use Mix.Task

  @impl Mix.Task
  def run([arg]) do
    Mix.Task.run("app.start")

    # REVIEW: Maybe use OptionParser for parsing args.
    setup(arg)
  end

  # ==============================================================================
  # Used to initialize the Super Admin
  # ==============================================================================
  # It uses the following environment variables, to set the first user up:
  # - SUPER_ADMIN_USER_IDS
  # - SUPER_ADMIN_USER_ID
  # - SUPER_ADMIN_USER_NAME
  # - SUPER_ADMIN_USER_EMAIL
  # - SUPER_ADMIN_USER_PASSWORD
  defp setup("super_admin") do
    super_admin_user = Application.get_env(:derpy_coder, :super_admin_user)

    case DerpyCoder.Accounts.get_user_by_email(super_admin_user.email) do
      nil ->
        {:ok, _} =
          DerpyCoder.Accounts.register_super_admin(%{
            id: super_admin_user.id,
            name: super_admin_user.name,
            email: super_admin_user.email,
            password: super_admin_user.password,
            password_confirmation: super_admin_user.password
          })

        IO.puts("Super Admin created successfully!")

      _ ->
        IO.puts("Super Admin already exists!")
    end
  end
end
