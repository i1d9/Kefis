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
  Transaction,
  Warehouse
}

alias Ecto.Changeset

# Create a Super User Account
super_user = %{
  first_name: "John",
  second_name: "Doe",
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

retailers = [
  %{
    email: "popup_micro@retailer.com",
    lat: -1.262093,
    lng: 36.833749,
    location: "Kiambu",
    phone: "2542051455",
    type: "retailer",
    name: "Mirco Pop-Up"
  },
  %{
    email: "expressstores@retailer.com",
    lat: -1.261899,
    lng: 36.825721,
    location: "Mtama Road",
    phone: "2540052491",
    type: "retailer",
    name: "Express Stores"
  },
  %{
    email: "nuvita@retailer.com",
    lat: -1.258606,
    lng: 36.835578,
    location: "Serengeti Avenue",
    phone: "25412051455",
    type: "retailer",
    name: "Eastmatt Stores"
  },
  %{
    email: "buyall@retailer.com",
    lat: -1.244324,
    lng: 36.856212,
    location: "Pipeline Estate Road",
    phone: "2544057112",
    type: "retailer",
    name: "Buy All Kenya"
  },
  %{
    email: "valleysupermarket@retailer.com",
    lat: -1.260236,
    lng: 36.856435,
    location: "Utalii Lane",
    phone: "2547307000",
    type: "retailer",
    name: "Kahawa Valley Supermarket"
  },
  %{
    email: "cleansupermkt@retailer.com",
    lat: -1.238864,
    lng: 36.855890,
    location: "Coffee Garden Road",
    phone: "2540651256",
    type: "retailer",
    name: "Cleanshelf Supermarket LTD"
  },
  %{
    email: "bestprice@retailer.com",
    lat: -1.317246,
    lng: 36.823211,
    location: "Kagondo Road",
    phone: "25401021883",
    type: "retailer",
    name: "Best Price Shop Factory"
  },
  %{
    email: "dukasmart@retailer.com",
    lat: -1.315410,
    lng: 36.836455,
    location: "Zanzibar Road",
    phone: "2542065125",
    type: "retailer",
    name: "Smart Duka LTD"
  },
  %{
    email: "malian@retailer.com",
    lat: -1.314499,
    lng: 36.838291,
    location: "Kapiti Road",
    phone: "25420651251",
    type: "retailer",
    name: "Malian Limited"
  }
]

"""
Tried Ecto.Multi.new() but it doesn't work 🙂 I'm justifiying the loop
"""

for retailer_details <- retailers do
  names = String.split(retailer_details.name, " ")

  retailer_user = %{
    first_name: Enum.at(names, 0),
    second_name: Enum.at(names, 1),
    phone: retailer_details.phone,
    role: "retailer_admin",
    email: retailer_details.email,
    password: retailer_details.email,
    password_confirmation: retailer_details.email
  }

  retailer_user = User.admin_changeset(%User{}, retailer_user)
  retailer_user = Repo.insert!(retailer_user)

  retailer =
    retailer_user
    |> Ecto.build_assoc(:partner)
    |> Partner.changeset(retailer_details)
    |> Repo.insert!()

  retailer_account_details = %{
    balance: 0,
    status: "active"
  }

  retailer_money_account =
    Account.changeset(%Account{}, retailer_account_details)
    |> Ecto.Changeset.put_assoc(:partner, retailer)
    |> Repo.insert!()

  IO.inspect(retailer)
end
