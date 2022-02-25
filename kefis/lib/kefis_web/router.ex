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
    get "/new/partner", AdminController, :new_partner
    post "/new/partner", AdminController, :create_new_partner

    get "/new/partner/user", AdminController, :new_partner_user
    post "/new/partner/user", AdminController, :create_partner_user
    get "/partners", AdminController, :list_partners


    get "/warehouse", AdminController, :list_warehouse
    get "/warehouse/new", AdminController, :new_warehouse
    post "/warehouse/new", AdminController, :create_warehouse
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

  # Other scopes may use custom stacks.
  # scope "/api", KefisWeb do
  #   pipe_through :api
  # end

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
