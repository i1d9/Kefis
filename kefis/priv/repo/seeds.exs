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
alias Kefis.{Users.User, Repo, Users, Products}
alias Kefis.Chain.{Partner, Collection, Product, Account, Driver, Dispatch, DispatchDetails, Order, OrderDetail, Transaction, Warehouse}
alias Ecto.Changeset

#Create a Super User Account
super_user = %{
  first_name: "User",
  second_name: "Zero",
  phone: "254712345418",
  email: "userzero@gmail.com",
  role: "super",
  password: "userzero@gmail.com",
  password_confirmation: "userzero@gmail.com"}

super_user = User.admin_changeset(%User{}, super_user)
super_user = Repo.insert!(super_user)

#Create a Supplier account
supplier_user = %{
  first_name: "User",
  second_name: "One",
  phone: "254712345678",
  email: "userone@gmail.com",
  role: "supplier_admin",
  password: "userone@gmail.com",
  password_confirmation: "userone@gmail.com"}
supplier_user = User.admin_changeset(%User{}, supplier_user)
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
  phone: "254712387654",
  role: "retailer_admin",
  email: "usertwo@gmail.com",
  password: "usertwo@gmail.com",
  password_confirmation: "usertwo@gmail.com"}
retailer_user = User.admin_changeset(%User{}, retailer_user)
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

  lat: -1.268870,
  lng: 36.785554,
  location: "Mugumoini",
  phone: "254712983876",
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

  Products.create(supplier, product_detail)

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
order_detail = OrderDetail.changeset(%OrderDetail{}, order_detail)
|> Changeset.put_assoc(:product, order_detail_product)
|> Changeset.put_assoc( :partner, order_detail_supplier)
|> Changeset.put_assoc( :order, order)
|> Repo.insert!()


#Create a Driver User Account
driver_user = %{
  first_name: "User",
  second_name: "Three",
  phone: "254772327411",
  email: "userthree@gmail.com",
  role: "driver",
  password: "userthree@gmail.com",
  password_confirmation: "userthree@gmail.com"}

driver_user = User.admin_changeset(%User{}, driver_user)
driver_user = Repo.insert!(driver_user)

driver_details = %{
  vehicle: "KBT124BH",
  trips: 0
}

driver = driver_user
  |> Ecto.build_assoc(:driver)
  |> Driver.changeset(driver_details)
  |> Repo.insert!()


#Create Warehouse
warehouse_details = %{
  location_name: "Madaraka",
  lng: -123.32,
  lat: 32.2
}

warehouse_changeset = Warehouse.changeset(%Warehouse{}, warehouse_details)
warehouse = Repo.insert!(warehouse_changeset)


collection_details = %{
  status: "initialised",
  value: 4000
}

collection = Collection.changeset(%Collection{}, collection_details)
  |> Ecto.Changeset.put_assoc( :driver, driver)
  |> Ecto.Changeset.put_assoc( :partner, supplier)
  |> Ecto.Changeset.put_assoc( :warehouse, warehouse)
  |> Ecto.Changeset.put_assoc( :order_detail, order_detail)
  |> Repo.insert!()

data_dispatch = %{
  status: "Initialised"
}

dispatch = Dispatch.changeset(%Dispatch{}, data_dispatch)
  |> Ecto.Changeset.put_assoc( :driver, driver)
  |> Ecto.Changeset.put_assoc( :order, order_result)
  |> Ecto.Changeset.put_assoc( :warehouse, warehouse)
  |> Repo.insert!()



order = Repo.get(Order, 1)

order_detail_info = %{price: 50, quantity: 5000, status: "done"}
order_detail = Repo.get(Order, 1)
  |> Ecto.Changeset.change(, order_detail_info)
  |> Ecto.build_assoc(:order_details)
  |> Repo.insert!()


def add_detail_to_order(order) do
  order_detail_info = %{price: 50, quantity: 5000, status: "done"}
  order_detail_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail_info)
  order_detail_changeset = Ecto.Changeset.change(order_detail_changeset)
  order_detail_changeset = Ecto.Changeset.put_assoc(order_detail_changeset, :order, order)
  order_detail = Repo.insert(order_detail_changeset)
  order_detail_info = %{price: 50, quantity: 5000, status: "done"}
  order_detail_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail_info)
  order_detail = Repo.insert(order_detail_changeset)
end


order_detail_info = %{price: 50, quantity: 5000, status: "done"}
order_detail_info_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail_info)
order_info = %{value: 5000, status: "shjfd"}
order_changeset = Order.changeset(%Order{}, order_info)
order_changeset= Ecto.Changeset.change(order_changeset)
#order_changeset = Ecto.Changeset.put_assoc(order_changeset, :order_details, [order_detail_info, order_detail_info, order_detail_info])
order_detail_info_changeset = Changeset.put_assoc(order_detail_info_changeset, :product, product)
order_detail_info_changeset = Changeset.put_assoc(order_detail_info_changeset, :partner, partner)
order_changeset = Ecto.Changeset.put_assoc(order_changeset, :order_details, [order_detail_info_changeset])


partner = Repo.get(Partner, 1)
product = Repo.get(Product, 1)
order_detail = %{status: "lol", quantity: 34, price: 323}
order_detail_changeset = OrderDetail.changeset(%OrderDetail{}, order_detail)
order_detail_changeset = Changeset.put_assoc(order_detail_changeset, :product, product)
order_detail_changeset = Changeset.put_assoc(order_detail_changeset, :partner, partner)

Enum.find(products, fn map -> Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end) end)
