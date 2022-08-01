defmodule DerpyCoder.Accounts.Policy do
  @moduledoc """
  Policy: Used to authorize user access
  """
  alias DerpyCoder.Accounts.User

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(User.t(), action(), entity()) :: boolean()
  def can?(user, action, entity)

  def can?(%User{id: id, role: :super_admin}, _, _), do: DerpyCoder.Accounts.is_super_admin?(id)
  def can?(%User{role: :admin}, _, DerpyCoderWeb.AdminDashboardLive), do: true
  def can?(%User{role: :user}, _, DerpyCoderWeb.UserDashboardLive), do: true

  def can?(_, _, _), do: false
end
