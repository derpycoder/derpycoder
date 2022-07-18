defmodule DerpyCoder.Release do
  def init_super_admin do
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
