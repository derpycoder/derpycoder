defimpl FunWithFlags.Group, for: DerpyCoder.Accounts.User do
  def in?(%{email: email}, :employee), do: Regex.match?(~r/@derpycoder.com$/, email)
  def in?(%{role: :user}, :user), do: true
  def in?(%{role: :admin}, :admin), do: true
  def in?(%{role: :super_admin, groups: _groups}, _group), do: true
  def in?(%{groups: nil}, _), do: false
  def in?(%{groups: groups}, group), do: String.to_atom(group) in groups
  def in?(_, _), do: false
end

defimpl FunWithFlags.Actor, for: DerpyCoder.Accounts.User do
  def id(%{id: id}) do
    "user:#{id}"
  end
end

defmodule DerpyCoder.Accounts.User do
  @moduledoc """
  Houses the User Schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.{Changeset, Schema}

  @timestamps_opts [type: :utc_datetime_usec]
  @primary_key {:id, ExKsuid.EctoType, autogenerate: true}
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true, redact: true
    field :hashed_password, :string, redact: true
    field :confirmed_at, :utc_datetime_usec

    field :role, RolesEnum, default: :user
    field :groups, {:array, GroupsEnum}
    field :locked_at, :utc_datetime_usec

    timestamps()
  end

  @spec lock_changeset(Schema.t() | Changeset.t()) :: Changeset.t()
  def lock_changeset(user_or_changeset) do
    changeset = Changeset.change(user_or_changeset)
    locked_at = DateTime.utc_now()

    case Changeset.get_field(changeset, :locked_at) do
      nil -> Changeset.change(changeset, locked_at: locked_at)
      _any -> Changeset.add_error(changeset, :locked_at, "already set")
    end
  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password, :groups])
    |> validate_email()
    |> validate_password(opts)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, DerpyCoder.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      |> put_change(:hashed_password, Argon2.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  @doc """
  A user changeset for changing the password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password(opts)
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = DateTime.utc_now()
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Argon2.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%DerpyCoder.Accounts.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Argon2.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Argon2.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  @doc """
  A user changeset for registering admins.
  """
  def admin_registration_changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> registration_changeset(attrs)
    |> put_change(:role, :admin)
  end

  @doc """
  A user changeset for registering super admin.
  """
  def super_admin_registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :confirmed_at])
    |> registration_changeset(attrs)
    |> put_change(:role, :super_admin)
    |> put_change(:groups, ~w(super_admin)a)
  end
end
