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
alias DerpyCoder.Photos.Photo

for i <- 0..10 do
  %Photo{
    title: Faker.Person.En.first_name(),
    description: Faker.Lorem.Shakespeare.En.hamlet(),
    photo_url: "https://source.unsplash.com/random/#{i}"
  }
  |> Repo.insert!()
end
