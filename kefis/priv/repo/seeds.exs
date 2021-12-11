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
alias Kefis.{Users.User, Repo, Users, Chain.Product, Chain.Partner}


supplier_user = %{
  first_name: "User",
  second_name: "One",
  phone: "+254712345678",
  email: "userone@gmail.com",
  role: "supplier_user",
  password: "userone@gmail.com",
  password_confirmation: "userone@gmail.com"}
supplier_user = User.registration_changeset(%User{}, supplier_user)
supplier_user = Repo.insert!(supplier_user)

retailer_user = %{
  first_name: "User",
  second_name: "Two",
  phone: "+254712387654",
  role: "retailer_user",
  email: "usertwo@gmail.com",
  password: "usertwo@gmail.com",
  password_confirmation: "usertwo@gmail.com"}
retailer_user = User.registration_changeset(%User{}, retailer_user)
retailer_user = Repo.insert!(retailer_user)


supplier = %{
  contact_email: "user@supplier.com",
  contact_phone: "+254709370049",
  lat: -1.337517,
  lng:36.808900,
  location: "Mugumoini",
  phone: "254712387654",
  type: "supplier",
  name: "Blue Band"
}
supplier = supplier_user
|> Ecto.build_assoc(:partners)
|> Partner.changeset(supplier)
|> Repo.insert!(supplier)


retailer = %{
  contact_email: "user@retailer.com",
  contact_phone: "+25409709370049",
  lat: -1.268870,
  lng: 36.785554,
  location: "Mugumoini",
  phone: "25471298387654",
  type: "retailer",
  name: "Sanford and Sons WholeSalers"
}
retailer = retailer_user
|> Ecto.build_assoc(:partners)
|> Partner.changeset(retailer)
|> Repo.insert!(retailer)


for i <- 1..10 do
  product_detail = %{
  name: "Product #{i}",
  category: "shoes",
  price: 5,
  sku: "HJABJHbjhbsdh&(@&*7w48",
  image: "image.jpg"
  }

  supplier
  |> Ecto.build_assoc(:products)
  |> Product.changeset(product_detail)
  |> Repo.insert!()

end
