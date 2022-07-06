defmodule DerpyCoderWeb.Roles do
  @moduledoc """
  Defines roles related functions.
  """

  alias DerpyCoder.Accounts.User

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(%User{}, entity(), action()) :: boolean()
  def can?(user, entity, action)
  def can?(%User{role: :admin}, %{}, _any), do: true
  def can?(%User{}, %{}, :index), do: true
  def can?(%User{}, %{}, :new), do: true
  def can?(%User{}, %{}, :show), do: true
  def can?(%User{id: id}, %{user_id: id}, :edit), do: true
  def can?(%User{id: id}, %{user_id: id}, :delete), do: true
  def can?(_, _, _), do: false
end
