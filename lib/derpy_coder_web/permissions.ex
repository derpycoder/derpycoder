defmodule DerpyCoderWeb.Permissions do
  @moduledoc """
  Used to initialize the default permissions for each group or resource.
  Powered by FunWithFlags.
  """

  @doc """
  Used to grant permissions to groups or resources.
  """
  def grant() do
    # Since Indexing & Viewing is public by default, adding these permissions don't make sense!
    # FunWithFlags.enable(:index_photos, for_group: :photography)
    # FunWithFlags.enable(:show_photos, for_group: :photography)
    FunWithFlags.enable(:new_photos, for_group: :photography)
    FunWithFlags.enable(:edit_photos, for_group: :photography)
    FunWithFlags.enable(:delete_photos, for_group: :photography)
  end

  @doc """
  Used to redact permissions for groups & resources.
  """
  def deny() do
    # If Admin, is to be treaded like normal user, then below flags can be removed.
    # And admin's new & edit power can be restricted in scope.
    FunWithFlags.disable(:new_photos, for_group: :admin)
    FunWithFlags.disable(:edit_photos, for_group: :admin)
  end
end
