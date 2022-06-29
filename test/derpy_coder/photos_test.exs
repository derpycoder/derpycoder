defmodule DerpyCoder.PhotosTest do
  use DerpyCoder.DataCase

  alias DerpyCoder.Photos

  describe "photos" do
    alias DerpyCoder.Photos.Photo

    import DerpyCoder.PhotosFixtures

    @invalid_attrs %{
      description: nil,
      downloads: nil,
      likes: nil,
      photo_url: nil,
      title: nil,
      views: nil
    }

    test "list_photos/0 returns all photos" do
      photo = photo_fixture()
      assert Photos.list_photos() == [photo]
    end

    test "get_photo!/1 returns the photo with given id" do
      photo = photo_fixture()
      assert Photos.get_photo!(photo.id) == photo
    end

    test "create_photo/1 with valid data creates a photo" do
      valid_attrs = %{
        description: "some description",
        downloads: 42,
        likes: 42,
        photo_url: "https://placekitten.com/515/515",
        title: "some title",
        views: 42
      }

      assert {:ok, %Photo{} = photo} = Photos.create_photo(valid_attrs)
      assert photo.description == "some description"
      assert photo.downloads == 42
      assert photo.likes == 42
      assert photo.photo_url == "https://placekitten.com/515/515"
      assert photo.title == "some title"
      assert photo.views == 42
    end

    test "create_photo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Photos.create_photo(@invalid_attrs)
    end

    test "update_photo/2 with valid data updates the photo" do
      photo = photo_fixture()

      update_attrs = %{
        description: "some updated description",
        downloads: 43,
        likes: 43,
        photo_url: "https://dummyimage.com/942x942",
        title: "some updated title",
        views: 43
      }

      assert {:ok, %Photo{} = photo} = Photos.update_photo(photo, update_attrs)
      assert photo.description == "some updated description"
      assert photo.downloads == 43
      assert photo.likes == 43
      assert photo.photo_url == "https://dummyimage.com/942x942"
      assert photo.title == "some updated title"
      assert photo.views == 43
    end

    test "update_photo/2 with invalid data returns error changeset" do
      photo = photo_fixture()
      assert {:error, %Ecto.Changeset{}} = Photos.update_photo(photo, @invalid_attrs)
      assert photo == Photos.get_photo!(photo.id)
    end

    test "delete_photo/1 deletes the photo" do
      photo = photo_fixture()
      assert {:ok, %Photo{}} = Photos.delete_photo(photo)
      assert_raise Ecto.NoResultsError, fn -> Photos.get_photo!(photo.id) end
    end

    test "change_photo/1 returns a photo changeset" do
      photo = photo_fixture()
      assert %Ecto.Changeset{} = Photos.change_photo(photo)
    end
  end
end
