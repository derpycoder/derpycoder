defmodule DerpyCoderWeb.Roles do
  @moduledoc """
  Defines roles related functions.
  """

  alias DerpyCoder.Accounts.User
  alias DerpyCoder.Photos.Photo

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(User.t(), entity(), action()) :: boolean()
  def can?(user, entity, action)
  def can?(%User{role: :admin}, %{}, _), do: true

  def can?(%User{}, %Photo{}, :index), do: true
  def can?(%User{}, %Photo{}, :new), do: true
  def can?(%User{}, %Photo{}, :show), do: true
  # def can?(%User{}, %Photo{}, action) when action in ~w[index new show]a, do: true

  def can?(%User{id: id}, %Photo{user_id: id}, :edit), do: true
  def can?(%User{id: id}, %Photo{user_id: id}, :delete), do: true
  # def can?(%User{id: id}, %Photo{user_id: id}, action) when action in ~w[edit delete]a, do: true

  def can?(_, _, _), do: false
end
