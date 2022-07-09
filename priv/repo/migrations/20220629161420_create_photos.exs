defmodule DerpyCoder.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos, primary_key: false) do
      add(:id, :binary, primary_key: true)
      add(:title, :string, null: false)
      add(:description, :string)
      add(:photo_url, :string, null: false)
      add(:views, :integer, default: 0, null: false)
      add(:downloads, :integer, default: 0, null: false)
      add(:likes, :integer, default: 0, null: false)
      add(:width, :integer, null: false)
      add(:height, :integer, null: false)

      add(:user_id, references(:users, on_delete: :delete_all), null: false)

      timestamps()
    end

    create(index(:photos, [:user_id]))
  end
end
