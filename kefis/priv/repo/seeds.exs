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
alias Kefis.{Users.User, Repo, Users, Products, Accounts}

alias Kefis.Chain.{
  Partner,
  Collection,
  Product,
  Account,
  Driver,
  Dispatch,
  DispatchDetails,
  Order,
  OrderDetail,
  Transaction,iex
  Warehouse
}

alias Ecto.Changeset

# Create a Super User Account
super_user = %{
  first_name: "User",
  second_name: "Zero",
  phone: "254712345418",
  email: "admin@gmail.com",
  role: "super",
  password: "admin@gmail.com",
  password_confirmation: "admin@gmail.com"
}

super_user = User.admin_changeset(%User{}, super_user)
super_user = Repo.insert!(super_user)

suppliers = [
  %{
    email: "centro@supplier.com",
    lat: -1.344601,
    lng: 36.735410,
    location: "Kiambu",
    phone: "2542051455",
    type: "supplier",
    name: "Centro Food"
  },
  %{
    email: "palmhouse@supplier.com",
    lat: -1.234766,
    lng: 36.894712,
    location: "Githunguri Road",
    phone: "2542051455",
    type: "supplier",
    name: "Palmhouse Dairies"
  },
  %{
    email: "nuvita@supplier.com",
    lat: -1.321948,
    lng: 36.884756,
    location: "Kiambu",
    phone: "2542051455",
    type: "supplier",
    name: "Nuvita Biscuits"
  },
  %{
    email: "britannia@supplier.com",
    lat: -1.298265,
    lng: 36.714811,
    location: "Kiambu",
    phone: "2542044412",
    type: "supplier",
    name: "Britiana Industries Limited"
  },
  %{
    email: "kenafric@supplier.com",
    lat: -1.264456,
    lng: 36.708803,
    location: "Industrial Area",
    phone: "2547307000",
    type: "supplier",
    name: "Kenafric Limited"
  },
  %{
    email: "alphadiary@supplier.com",
    lat: -1.301011,
    lng: 36.837549,
    location: "Mogadishu Road",
    phone: "2540651256",
    type: "supplier",
    name: "Alpha Diary Products LTD"
  },
  %{
    email: "chemilil@supplier.com",
    lat: -1.238027,
    lng: 36.859178,
    location: "Mombasa Road",
    phone: "25402031883",
    type: "supplier",
    name: "Chemelil Sugar Factory"
  },
  %{
    email: "alphafine@supplier.com",
    lat: -1.288998,
    lng: 36.865014,
    location: "Enterprise Road",
    phone: "2542065125",
    type: "supplier",
    name: "Alpha Fine Food LTD"
  },
  %{
    email: "bico_oil@supplier.com",
    lat: -1.384695,
    lng: 36.943624,
    location: "Enterprise Road",
    phone: "25420651251",
    type: "supplier",
    name: "Bidco Oil Refineries Limited"
  }
]

"""
Tried Ecto.Multi.new() but it doesn't work 🙂 I'm justifiying the loop
"""

for supplier_details <- suppliers do
  names = String.split(supplier_details.name, " ")

  supplier_user = %{
    first_name: Enum.at(names, 0),
    second_name: Enum.at(names, 1),
    phone: supplier_details.phone,
    role: "supplier_admin",
    email: supplier_details.email,
    password: supplier_details.email,
    password_confirmation: supplier_details.email
  }

  supplier_user = User.admin_changeset(%User{}, supplier_user)
  supplier_user = Repo.insert!(supplier_user)

  supplier =
    supplier_user
    |> Ecto.build_assoc(:partner)
    |> Partner.changeset(supplier_details)
    |> Repo.insert!()

  supplier_account_details = %{
    balance: 0,
    status: "active"
  }

  supplier_money_account =
    Account.changeset(%Account{}, supplier_account_details)
    |> Ecto.Changeset.put_assoc(:partner, supplier)
    |> Repo.insert!()

  IO.inspect(supplier)
end
