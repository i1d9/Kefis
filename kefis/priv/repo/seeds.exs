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
alias Kefis.Chain.{Partner, Collection, Product, Account, Driver, Dispatch, DispatchDetails, Order, OrderDetail, Transaction, Warehouse}

#Create a Supplier account
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

#Create a monetary account for the supplier
supplier_account_details = %{
  balance: 0,
  status: "active"
}
supplier_money_account = Account.changeset(%Account{}, supplier_account_details)
|> Ecto.Changeset.put_assoc(:user, supplier_user)
|> Repo.insert!()


#Create a Retailer Account
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

#Create a monetary account for the retailer
retailer_account_details = %{
  balance: 0,
  status: "active"
}
retailer_money_account = Account.changeset(%Account{}, retailer_account_details)
|> Ecto.Changeset.put_assoc(:user, retailer_user)
|> Repo.insert!()

#Create a Supplier record
supplier_details = %{
  contact_email: "user@supplier.com",
  contact_phone: "+254709370049",
  lat: -1.337517,
  lng: 36.808900,
  location: "Mugumoini",
  phone: "254712387654",
  type: "supplier",
  name: "Blue Band"
}
supplier = supplier_user
  |> Ecto.build_assoc(:partner)
  |> Partner.changeset(supplier_details)
  |> Repo.insert!()

#Create a Retailer record
retailer_details = %{
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
  |> Ecto.build_assoc(:partner)
  |> Partner.changeset(retailer_details)
  |> Repo.insert!()

#Deposit KES 5000 in the retailer account
transaction_details = %{
  amount: 5000,
  status: "confirmed",
  type: "deposit"
}

transcation_changeset = Transaction.changeset(%Transaction{}, transaction_details)
|> Ecto.Changeset.put_assoc(:account, retailer_money_account)
|> Repo.insert!()



#Create Dummy Products and associate them with the supplier
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


#Create a dummy supply order associated with the retailer above
order = %{
  value: 5000,
  status: "initiated"
}

order_result = retailer
|> Ecto.build_assoc(:orders)
|> Order.changeset(order)
|> Repo.insert!()

#Create order details
order_detail_product = Repo.get(Product, 1)
order_detail_supplier = Repo.get(Partner, 1)
order = Repo.get(Order, 2)
order_detail = %{
  status: "initiated",
  price: 10,
  quantity: 500,
}

#Build Relaionships
order_detail_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail)
|> Ecto.Changeset.put_assoc(:product, order_detail_product)
|> Ecto.Changeset.put_assoc( :partner, order_detail_supplier)
|> Ecto.Changeset.put_assoc( :order, order)
|> Repo.insert!()
