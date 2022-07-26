defmodule DerpyCoder.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    RolesEnum.create_type()
    GroupsEnum.create_type()

    create table(:users, primary_key: false) do
      add(:id, :binary, primary_key: true)
      add(:email, :string, null: false)
      add(:hashed_password, :string, null: false)
      add(:confirmed_at, :utc_datetime_usec)

      add(:role, RolesEnum.type())
      add(:groups, {:array, GroupsEnum.type()})
      add(:locked_at, :utc_datetime_usec)

      timestamps()
    end

    create(unique_index(:users, [:email]))

    create table(:users_tokens, primary_key: false) do
      add(:id, :binary, primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), null: false)
      add(:token, :binary, null: false)
      add(:context, :string, null: false)
      add(:sent_to, :string)

      timestamps(updated_at: false)
    end

    create(index(:users_tokens, [:user_id]))
    create(unique_index(:users_tokens, [:context, :token]))
  end
end
