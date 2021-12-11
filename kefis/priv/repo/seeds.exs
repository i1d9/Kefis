# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kefis.Repo.insert!(%Kefis.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Kefis.{Users.User, Repo, Users}


user = %{
  first_name: "Ian",
  second_name: "Nalyanya",
  phone: "+254712386596",
  email: "ian@gmail.com",
  password: "Brachiosaurus2020",
  password_confirmation: "Brachiosaurus2020"}

user = User.registration_changeset(%User{}, user)
IO.inspect(user)

user = Repo.insert!(user)
IO.inspect(user)
