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

alias DerpyCoder.Repo
alias DerpyCoder.Accounts
alias DerpyCoder.Photos.Photo

Accounts.register_admin(%{
  email: "admin@derpycoder.com",
  password: "janmiq-robget-9byVtu",
  password_confirmation: "janmiq-robget-9byVtu"
})

Accounts.register_user(%{
  email: "abhijit@derpycoder.com",
  password: "gesDeh-5cifqy-buxtec",
  password_confirmation: "gesDeh-5cifqy-buxtec"
})

width_range = 3000..6000
height_range = 3000..6000

for _ <- 1..10 do
  width = Enum.random(width_range)
  height = Enum.random(height_range)

  ratio = width / height

  # width = Enum.random([640, 1920, 2400])
  width = 640
  height = Kernel.round(width / ratio)

  %Photo{
    title: Faker.Person.En.first_name(),
    description: Faker.Lorem.Shakespeare.En.hamlet(),
    photo_url: "https://source.unsplash.com/random/#{width}x#{height}",
    width: width,
    height: height
  }
  |> Repo.insert!()
end
