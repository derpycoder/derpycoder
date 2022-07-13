defmodule DerpyCoderWeb.Roles do
  @moduledoc """
  Defines roles related functions.
  """

  alias DerpyCoder.Accounts.User
  alias DerpyCoder.Photos.Photo

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(User.t(), action(), entity()) :: boolean()
  def can?(user, action, entity)
  def can?(%User{role: :admin}, _, %{}), do: true

  def can?(%User{}, :index, Photo), do: true
  def can?(%User{}, :new, Photo), do: true
  def can?(%User{}, :show, %Photo{}), do: true
  # def can?(%User{}, %Photo{}, action) when action in ~w[index new show]a, do: true

  def can?(%User{id: id}, :edit, %Photo{user_id: id}), do: true
  def can?(%User{id: id}, :delete, %Photo{user_id: id}), do: true
  # def can?(%User{id: id}, %Photo{user_id: id}, action) when action in ~w[edit delete]a, do: true

  def can?(_, _, _), do: false
end
