defmodule DerpyCoderWeb.Admin do
  @moduledoc """
  Defines admin related functions.
  """

  alias DerpyCoder.Accounts.User

  @type entity :: struct()
  @type action :: :new | :index | :edit | :show | :delete

  @spec can?(User.t(), action(), entity()) :: boolean()
  def can?(user, action, entity)

  def can?(%User{role: :admin}, _, %{}), do: true
  def can?(%User{role: :super_admin}, _, %{}), do: true
  def can?(_, _, _), do: false
end
