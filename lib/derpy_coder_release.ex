defmodule DerpyCoder.Release do
  def init_super_admin do
    {admin_user_id, admin_user_name, admin_user_email, admin_user_password} = {
      Application.get_env(:derpy_coder, :admin_user_id),
      Application.get_env(:derpy_coder, :admin_user_name),
      Application.get_env(:derpy_coder, :admin_user_email),
      Application.get_env(:derpy_coder, :admin_user_password)
    }

    case DerpyCoder.Accounts.get_user_by_email(admin_user_email) do
      nil ->
        {:ok, _} =
          DerpyCoder.Accounts.register_super_admin(%{
            id: admin_user_id,
            name: admin_user_name,
            email: admin_user_email,
            password: admin_user_password,
            password_confirmation: admin_user_password
          })

        IO.puts("Super Admin created successfully!")

      _ ->
        IO.puts("Super Admin already exists!")
    end
  end
end
