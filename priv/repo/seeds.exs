# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     DerpyCoder.Repo.insert!(%DerpyCoder.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias DerpyCoder.Accounts
alias DerpyCoder.Accounts.User
alias DerpyCoder.Photos

FunWithFlags.enable(:index_photos, for_group: :photographer)
FunWithFlags.enable(:new_photos, for_group: :photographer)
FunWithFlags.enable(:show_photos, for_group: :photographer)
FunWithFlags.enable(:edit_photos, for_group: :photographer)
FunWithFlags.enable(:delete_photos, for_group: :photographer)

{:ok, admin} =
  Accounts.register_admin(%{
    email: "admin@derpycoder.com",
    password: "123456789abc",
    password_confirmation: "123456789abc",
    groups: ~w(photographer)a
  })

{:ok, abhijit} =
  Accounts.register_user(%{
    email: "abhijit@derpycoder.com",
    password: "123456789abc",
    password_confirmation: "123456789abc",
    groups: ~w(photographer)a
  })

{:ok, abhisek} =
  Accounts.register_user(%{
    email: "abhisek@derpycoder.com",
    password: "123456789abc",
    password_confirmation: "123456789abc",
    groups: ~w(photographer)a
  })

width_range = 3000..6000
height_range = 3000..6000

for i <- 1..10 do
  width = Enum.random(width_range)
  height = Enum.random(height_range)

  ratio = width / height

  # width = Enum.random([640, 1920, 2400])
  width = 640
  height = Kernel.round(width / ratio)

  %{
    user_id: admin.id,
    title: "Photo #{i}",
    description: "Admin",
    photo_url: "https://source.unsplash.com/random/#{width}x#{height}",
    width: width,
    height: height
  }
  |> Photos.create_photo()
end

for i <- 11..20 do
  width = Enum.random(width_range)
  height = Enum.random(height_range)

  ratio = width / height

  # width = Enum.random([640, 1920, 2400])
  width = 640
  height = Kernel.round(width / ratio)

  %{
    user_id: abhijit.id,
    title: "Photo #{i}",
    description: "Abhijit",
    photo_url: "https://source.unsplash.com/random/#{width}x#{height}",
    width: width,
    height: height
  }
  |> Photos.create_photo()
end

for i <- 21..30 do
  width = Enum.random(width_range)
  height = Enum.random(height_range)

  ratio = width / height

  # width = Enum.random([640, 1920, 2400])
  width = 640
  height = Kernel.round(width / ratio)

  %{
    user_id: abhisek.id,
    title: "Photo #{i}",
    description: "Abhisek",
    photo_url: "https://source.unsplash.com/random/#{width}x#{height}",
    width: width,
    height: height
  }
  |> Photos.create_photo()
end
