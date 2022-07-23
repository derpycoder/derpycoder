defmodule DerpyCoder.Photos do
  defdelegate can?(user, action, entity), to: DerpyCoder.Photos.Policy

  @moduledoc """
  The Photos context.
  """

  import Ecto.Query, warn: false
  alias DerpyCoder.Repo

  alias DerpyCoder.Photos.Photo

  @doc """
  Returns the list of photos.

  ## Examples

      iex> list_photos()
      [%Photo{}, ...]

  """
  def list_photos do
    Repo.all(Photo)
  end

  @doc """
  Gets a single photo.

  Raises `Ecto.NoResultsError` if the Photo does not exist.

  ## Examples

      iex> get_photo!(123)
      %Photo{}

      iex> get_photo!(456)
      ** (Ecto.NoResultsError)

  """
  def get_photo!(id), do: Repo.get!(Photo, id)

  @doc """
  Creates a photo.

  ## Examples

      iex> create_photo(%{field: value})
      {:ok, %Photo{}}

      iex> create_photo(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_photo(attrs \\ %{}) do
    %Photo{}
    |> Photo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a photo.

  ## Examples

      iex> update_photo(photo, %{field: new_value})
      {:ok, %Photo{}}

      iex> update_photo(photo, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_photo(%Photo{} = photo, attrs) do
    photo
    |> Photo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a photo.

  ## Examples

      iex> delete_photo(photo)
      {:ok, %Photo{}}

      iex> delete_photo(photo)
      {:error, %Ecto.Changeset{}}

  """
  def delete_photo(%Photo{} = photo) do
    Repo.delete(photo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking photo changes.

  ## Examples

      iex> change_photo(photo)
      %Ecto.Changeset{data: %Photo{}}

  """
  def change_photo(%Photo{} = photo, attrs \\ %{}) do
    Photo.changeset(photo, attrs)
  end

  # ==============================================================================
  # Scope: Used to fine tune the output from the Repo
  # ==============================================================================
  # Like guest user can see a index of photos, but not the private ones
  # However, logged in users can see index of all photos, even private ones

  # def scope(query, user, params) do
  #   scope_photos(query, user, params)
  # end

  # Signed in users can delete their own photos withing same organization
  # defp scope_photos(query, %User{role: :user, id: id}, _params) do
  #   query
  #   |> where(author_id: ^id)
  #   |> or_where(state: :published)
  # end

  # Super admins can access anything
  # defp scope_photos(query, %User{role: :admin}, _params), do: query

  # Anonymous users can access only published photos
  # defp scope_photos(query, _user, _params), do: query |> where(state: :published)
end
