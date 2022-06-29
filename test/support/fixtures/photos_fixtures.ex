defmodule DerpyCoder.PhotosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DerpyCoder.Photos` context.
  """

  @doc """
  Generate a photo.
  """
  def photo_fixture(attrs \\ %{}) do
    {:ok, photo} =
      attrs
      |> Enum.into(%{
        description: "some description",
        downloads: 42,
        likes: 42,
        photo_url: "https://placekitten.com/515/515",
        title: "some title",
        views: 42
      })
      |> DerpyCoder.Photos.create_photo()

    photo
  end
end
