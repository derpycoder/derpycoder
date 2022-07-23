defmodule DerpyCoder.Photos.Policy do
  @moduledoc """
  Policy: Used to authorize user access
  """
  alias DerpyCoder.Accounts.User
  alias DerpyCoder.Photos.Photo

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(User.t(), action(), entity()) :: boolean()
  def can?(user, action, entity)

  # ==============================================================================
  # Super Admin
  # ==============================================================================
  def can?(%User{role: :super_admin}, _, _), do: true

  # ==============================================================================
  # Admin
  # ==============================================================================
  def can?(%User{role: :admin} = user, :new, _),
    do: FunWithFlags.enabled?(:new_photos, for: user)

  def can?(%User{role: :admin} = user, :edit, _),
    do: FunWithFlags.enabled?(:edit_photos, for: user)

  def can?(%User{role: :admin} = user, _, Photo), do: FunWithFlags.Group.in?(user, :photography)
  def can?(%User{role: :admin}, _, _), do: true

  # ==============================================================================
  # User
  # ==============================================================================
  def can?(%User{} = user, :new, Photo), do: FunWithFlags.enabled?(:new_photos, for: user)

  def can?(%User{id: id} = user, :edit, %Photo{user_id: id}),
    do: FunWithFlags.enabled?(:edit_photos, for: user)

  def can?(%User{id: id} = user, :delete, %Photo{user_id: id}),
    do: FunWithFlags.enabled?(:delete_photos, for: user)

  def can?(_, _, _), do: false
end
