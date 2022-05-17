defmodule KefisWeb.Router do
  use KefisWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KefisWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug KefisWeb.ApiAuth, otp_app: :kefis
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: KefisWeb.ApiAuthErrorHandler
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: KefisWeb.AuthErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated,
      error_handler: KefisWeb.AuthErrorHandler
  end

  scope "/" do
    pipe_through [:browser, :not_authenticated]

    pow_routes()
  end

  scope "/", KefisWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", KefisWeb do
    pipe_through [:browser, :protected]
    resources "/users", UserController
    resources "/products", ProductController
    # resources "/partners", PartnerController

    get "/partners/user/new", PartnerController, :new_partner_user
    post "/partners/user/new", PartnerController, :create_partner_user
    get "/partners/user/:id", PartnerController, :show_partner_user
  end

  scope "/", KefisWeb do
    pipe_through [:browser, :not_authenticated]

    # get "/signup", RegistrationController, :new, as: :signup
    # post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", KefisWeb do
    pipe_through [:browser, :protected]

    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/admin", KefisWeb do
    pipe_through [:browser, :protected]


    live "/", Admin.IndexLive

    live "/warehouses", Admin.Warehouse.IndexLive, :list
    live "/warehouses/new", Admin.Warehouse.IndexLive, :new
    live "/warehouses/:id", Admin.Warehouse.IndexLive, :update

    live "/transactions", Admin.Transaction.IndexLive, :transaction_index
    live "/transactions/:id", Admin.Transaction.IndexLive, :transaction_detail

    live "/partners/new", Admin.Partner.NewLive
    live "/partners/retailer", Admin.Partner.IndexLive, :retailer
    live "/partners/supplier", Admin.Partner.IndexLive, :supplier

    live "/partners/:id", Admin.Partner.IndexLive, :partner_details
    live "/partners/:id/edit", Admin.Partner.IndexLive, :edit_partner
    live "/partners/:id/orders", Admin.Partner.IndexLive, :partner_order
    live "/partners/:id/orders/:id", Admin.Partner.IndexLive, :partner_order_details

    live "/partners/:id/products/", Admin.Partner.Product.IndexLive, :partner_products
    live "/partners/:id/products/new", Admin.Partner.Product.IndexLive, :new_partner_product
    live "/partners/:id/products/:product", Admin.Partner.Product.IndexLive, :show_partner_product
    live "/partners/:id/products/:product/edit", Admin.Partner.Product.IndexLive, :edit_partner_product

    live "/partners/:id/transactions", Admin.Partner.IndexLive, :partner_transactions

    live "/orders", Admin.Order.IndexLive, :index
    live "/orders/:id", Admin.Order.IndexLive, :detail
    live "/orders/:id/info", Admin.Order.IndexLive, :info

    live "/users", Admin.User.IndexLive

  end

  scope "/partners", KefisWeb do
    pipe_through [:browser, :protected]

    get "/", PartnerController, :index
    get "/products", PartnerController, :list_partner_products

    get "/products/new", PartnerController, :new_product
    post "/products/new", PartnerController, :create_product

    get "/partners/products/:id", PartnerController, :show_product
    get "/partners/products/:id/edit", PartnerController, :edit_product
    delete "/partners/products/:id/delete", PartnerController, :delete_product
  end

  scope "/drivers", KefisWeb do
    pipe_through [:browser, :protected, :driver]

    live "/", Driver.DashboardLive, :index
    live "/trips", Driver.TripsLive
    live "/trips/collection", Driver.TripsLive, :collections
    live "/trips/delivery", Driver.TripsLive, :delivery

    live "/order", Driver.OrderLive
  end

  scope "/r", KefisWeb do
    pipe_through [:browser, :protected, :retailer]
    # pipe_through [:browser]

    live "/", Retailer.IndexLive

    live "/order", Retailer.OrdersLive, :index
    live "/order/new", Retailer.NewLive
    live "/order/history", Retailer.OrdersLive, :history
    live "/order/:id", Retailer.OrdersLive, :show_order


    # get "/order/new", RetailerController, :order
    live "/order/info", Retailer.ConfirmOrderLive
  end

  scope "/pos", KefisWeb do
    pipe_through [:browser, :protected, :retailer]
    # pipe_through [:browser]

  end

  scope "/s", KefisWeb do
    pipe_through [:browser, :protected, :supplier]
    # pipe_through [:browser]

    get "/", SupplierController, :index
    get "/products", SupplierController, :list_partner_products

    get "/new/product", SupplierController, :new_product

    get "/orders", SupplierController, :my_orders
    get "/orders/:id/", SupplierController, :show_order_details
  end

  scope "/w", KefisWeb do
    # pipe_through [:browser, :protected, :warehouse]
    pipe_through [:browser]

    live "/", Warehouse.IndexLive
    live "/incoming", Warehouse.OrdersLive, :incoming
    live "/processing", Warehouse.OrdersLive, :processing
    live "/outgoing", Warehouse.OrdersLive, :outgoing
    live "/info", Warehouse.ShowDetailLive
  end

  # Other scopes may use custom stacks.
  scope "/api", KefisWeb do
    pipe_through :api

    post "/login", SessionController, :api_create, as: :api_login

    # delete "/logout", SessionController, :api_delete, as: :api_logout
    post "/session/renew", SessionController, :renew
  end

  scope "/api/admin", KefisWeb do
    # pipe_through [:api, :api_protected, :api_admin]
    pipe_through :api

    get "/partners", AdminController, :api_list_partners
    post "/partners/new", AdminController, :api_add_partner
    get "/partners/:id", AdminController, :api_admin_show_partner
    post "/partners/:id/edit", AdminController, :api_update_partner
    delete "/partners/:id", AdminController, :api_delete_partner
    get "/partners/:id/products", AdminController, :api_show_partner_w_products

    get "/partners/:id/products/:id", AdminController, :api_show_partner_w_products
    post "/partners/:id/products/new", AdminController, :api_add_product
    post "/partners/:id/products/:product_id/edit", AdminController, :api_update_product
    delete "/partners/:id/products/:product_id/delete", AdminController, :api_delete_product

    get "/orders", AdminController, :api_list_orders
    get "/orders/:id", AdminController, :api_show_order
  end

  scope "/api/s", KefisWeb do
    pipe_through [:api, :api_supplier]

    get "/partners", AdminController, :api_list_partners
    get "/partners/:id", AdminController, :api_show_partner
  end

  scope "/api/r", KefisWeb do
    pipe_through [:api, :api_retailer]

    get "/partners", AdminController, :api_list_partners
    get "/partners/:id", AdminController, :api_show_partner
  end

  scope "/api", KefisWeb do
    pipe_through [:api, :api_protected]
    delete "/logout", SessionController, :delete, as: :logout
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: KefisWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
