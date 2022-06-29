defmodule DerpyCoder.Photos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :description, :string
    field :downloads, :integer, default: 0
    field :likes, :integer, default: 0
    field :photo_url, :string
    field :title, :string
    field :views, :integer, default: 0

    timestamps()
  end

  @url ~r/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/\/=]*)/

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:title, :description, :downloads, :views, :likes, :photo_url])
    |> validate_required([:title, :photo_url])
    |> validate_length(:title, min: 2, max: 100)
    |> validate_length(:description, min: 2, max: 280)
    |> validate_format(:photo_url, @url, message: "must be a valid url")
  end
end
