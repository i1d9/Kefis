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
    #resources "/partners", PartnerController

    get "/partners/user/new", PartnerController, :new_partner_user
    post "/partners/user/new", PartnerController, :create_partner_user
    get "/partners/user/:id", PartnerController, :show_partner_user


  end


  scope "/", KefisWeb do
    pipe_through [:browser, :not_authenticated]

    #get "/signup", RegistrationController, :new, as: :signup
    #post "/signup", RegistrationController, :create, as: :signup
    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
  end

  scope "/", KefisWeb do
    pipe_through [:browser, :protected]

    delete "/logout", SessionController, :delete, as: :logout
  end

  scope "/admin", KefisWeb do
    pipe_through [:browser, :protected]

    get "/", AdminController, :index
    live "/live/new/partner", Admin.Partner.NewLive

    get "/new/partner", AdminController, :new_partner
    post "/new/partner", AdminController, :create_new_partner

    get "/new/partner/user", AdminController, :new_partner_user
    post "/new/partner/user", AdminController, :create_partner_user
    get "/partners", AdminController, :list_partners


    get "/warehouse", AdminController, :list_warehouse
    get "/warehouse/new", AdminController, :new_warehouse
    post "/warehouse/new", AdminController, :create_warehouse

    get "/user", AdminController, :list_users
    get "/user/:id", AdminController, :list_users


    get "/orders", AdminController, :list_orders

    live "/orders/:id", Admin.Order.ShowLive, :index
    live "/orders/:id/info", Admin.Order.ShowLive, :view_detail

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
    pipe_through [:browser]

    live "/", Driver.DashboardLive, :index
    live "/trips/collection", Driver.TripsLive, :collections
    live "/trips/delivery", Driver.TripsLive, :delivery
  end

  scope "/r", KefisWeb do
    pipe_through [:browser, :protected, :retailer]
    #pipe_through [:browser]

    live "/", Retailer.IndexLive
    live "/order/new", Retailer.NewLive


    get "/order/new", RetailerController, :order
    get "/order/:id", RetailerController, :show_order
    live "/order/info", Retailer.ConfirmOrderLive
  end


  scope "/s", KefisWeb do
    pipe_through [:browser, :protected, :supplier]
    #pipe_through [:browser]

    get "/", SupplierController,:index
    get "/products", SupplierController, :list_partner_products

    get "/new/product", SupplierController, :new_product


    get "/orders", SupplierController, :my_orders
    get "/orders/:id/", SupplierController, :show_order_details


  end


  scope "/w", KefisWeb do
    #pipe_through [:browser, :protected, :warehouse]
    pipe_through [:browser]

    live "/", Warehouse.IndexLive
    live "/incoming", Warehouse.OrdersLive, :incoming
    live "/outgoing", Warehouse.OrdersLive, :outgoing



  end

  # Other scopes may use custom stacks.
  scope "/api", KefisWeb do
    pipe_through :api


      post "/login", SessionController, :api_create, as: :api_login

    #delete "/logout", SessionController, :api_delete, as: :api_logout
    post "/session/renew", SessionController, :renew
  end

  scope "/api/admin", KefisWeb do
    #pipe_through [:api, :api_protected, :api_admin]
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
    pipe_through  [:api, :api_protected]
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
