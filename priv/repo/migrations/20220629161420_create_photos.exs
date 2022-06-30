defmodule DerpyCoder.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add(:title, :string, null: false)
      add(:description, :string)
      add(:photo_url, :string, null: false)
      add(:views, :integer, default: 0, null: false)
      add(:downloads, :integer, default: 0, null: false)
      add(:likes, :integer, default: 0, null: false)
      add(:width, :integer, null: false)
      add(:height, :integer, null: false)

      timestamps()
    end
  end
end
