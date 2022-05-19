defmodule KefisWeb.Retailer.ShellDashboardLive do
  use KefisWeb, :live_component

  def update(%{component: component, component_details: component_details} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
    }
  end

  def render(assigns) do
    ~H"""
    <div>
    <nav class="navbar navbar-dark navbar-theme-primary px-4 col-12 d-lg-none">
    <a class="navbar-brand me-lg-5" href="../../index.html">
      <img class="navbar-brand-dark" src="" alt="Kefis logo" /> <img
        class="navbar-brand-light" src="" alt="Kefis logo" />
    </a>
    <div class="d-flex align-items-center">
      <button class="navbar-toggler d-lg-none collapsed" type="button" data-bs-toggle="collapse"
        data-bs-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
    </nav>

    <nav id="sidebarMenu" class="sidebar d-lg-block bg-gray-800 text-white collapse" data-simplebar>
    <div class="sidebar-inner px-4 pt-3">
      <div class="user-card d-flex d-md-none align-items-center justify-content-between justify-content-md-center pb-4">
        <div class="d-flex align-items-center">
          <div class="avatar-lg me-4">
            <img src="" class="card-img-top rounded-circle border-white"
              alt={ @user.first_name }>
          </div>
          <div class="d-block">
            <h2 class="h5 mb-3">Hi, <%= @user.first_name %></h2>

            <%= link  to: Routes.logout_path(@socket, :delete), method: :delete, class: "dropdown-item d-flex align-items-center" do%>
            <svg class="dropdown-icon text-danger me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1">
                </path>
              </svg>Logout


          <% end %>

          </div>
        </div>
        <div class="collapse-close d-md-none">
          <a href="#sidebarMenu" data-bs-toggle="collapse" data-bs-target="#sidebarMenu" aria-controls="sidebarMenu"
            aria-expanded="true" aria-label="Toggle navigation">
            <svg class="icon icon-xs" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
              <path fill-rule="evenodd"
                d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                clip-rule="evenodd"></path>
            </svg>
          </a>
        </div>
      </div>
      <ul class="nav flex-column pt-3 pt-md-0">
        <li class="nav-item">
          <a href="../../index.html" class="nav-link d-flex align-items-center">
            <span class="sidebar-icon">
              <img src="" height="20" width="20" alt="Kefis Logo">
            </span>
            <span class="mt-1 ms-1 sidebar-text">Kefis</span>
          </a>
        </li>

        <li class="nav-item  active ">

          <%= link to: Routes.live_path(@socket, KefisWeb.Retailer.IndexLive), class: "nav-link" do%>
          <span class="sidebar-icon">
          <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
            <path d="M2 10a8 8 0 018-8v8h8a8 8 0 11-16 0z"></path>
            <path d="M12 2.252A8.014 8.014 0 0117.748 8H12V2.252z"></path>
          </svg>
        </span>
        <span class="sidebar-text">Dashboard</span>
          <% end %>

        </li>

        <li class="nav-item">

        <%= link to: Routes.orders_path(@socket, :list_my_transaction), class: "nav-link" do%>
        <span class="sidebar-icon">
        <i class="fa-solid fa-sack-dollar"></i>
      </span>
      <span class="sidebar-text">Transactions</span>
        <% end %>

      </li>



        <li class="nav-item">
        <span class="nav-link d-flex justify-content-between align-items-center" data-bs-toggle="collapse" data-bs-target="#submenu-components" aria-expanded="true">
          <span>
            <span class="sidebar-icon">
            <i class="fa fa-shopping-basket" aria-hidden="true"></i>

            </span>
            <span class="sidebar-text">Orders</span>
          </span>
          <span class="link-arrow">
            <svg class="icon icon-sm" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg>
          </span>
        </span>
        <div class="multi-level collapse show" role="list" id="submenu-components" aria-expanded="false" style="">
          <ul class="flex-column nav">
            <li class="nav-item">


            <%= link to: Routes.live_path(@socket, KefisWeb.Retailer.NewLive), class: "nav-link d-flex justify-content-between" do%>
            <span>

            <span class="sidebar-text">New</span>
          </span>
            <% end %>

            </li>
            <li class="nav-item ">



              <%= link  to: Routes.orders_path(@socket, :index), class: "nav-link" do%>
              <span class="sidebar-text">History</span>
              <% end%>
            </li>

          </ul>
        </div>
      </li>


        <li class="nav-item ">
          <a href="#" class="nav-link">
            <span class="sidebar-icon">
              <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                <path fill-rule="evenodd"
                  d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                  clip-rule="evenodd"></path>
              </svg>
            </span>
            <span class="sidebar-text">Settings</span>
          </a>
        </li>




      </ul>
    </div>
    </nav>


    <main class="content">

    <nav class="navbar navbar-top navbar-expand navbar-dashboard navbar-dark ps-0 pe-2 pb-0">
      <div class="container-fluid px-0">
        <div class="d-flex justify-content-between w-100" id="navbarSupportedContent">
          <div class="d-flex align-items-center">
            <!-- Search form -->
            <form class="navbar-search form-inline" id="navbar-search-main">
              <div class="input-group input-group-merge search-bar">
                <span class="input-group-text" id="topbar-addon">
                  <svg class="icon icon-xs" x-description="Heroicon name: solid/search"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fill-rule="evenodd"
                      d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
                      clip-rule="evenodd"></path>
                  </svg>
                </span>
                <input type="text" class="form-control" id="topbarInputIconLeft" placeholder="Search"
                  aria-label="Search" aria-describedby="topbar-addon">
              </div>
            </form>
            <!-- / Search form -->
          </div>
          <!-- Navbar links -->
          <ul class="navbar-nav align-items-center">
            <li class="nav-item dropdown">
              <a class="nav-link text-dark notification-bell unread dropdown-toggle" data-unread-notifications="true"
                href="#" role="button" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                <svg class="icon icon-sm text-gray-900" fill="currentColor" viewBox="0 0 20 20"
                  xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z">
                  </path>
                </svg>
              </a>

            </li>
            <li class="nav-item dropdown ms-lg-3">
              <a class="nav-link dropdown-toggle pt-1 px-0" href="#" role="button" data-bs-toggle="dropdown"
                aria-expanded="false">
                <div class="media d-flex align-items-center">
                  <img class="avatar rounded-circle" alt="Image placeholder"
                    src={Routes.static_path(@socket, "/images/user.png")}>
                  <div class="media-body ms-2 text-dark align-items-center d-none d-lg-block">
                    <span class="mb-0 font-small fw-bold text-gray-900">

                    <%= @user.first_name %> <%= @user.second_name %>
                    </span>

                  </div>
                </div>
              </a>
              <div class="dropdown-menu dashboard-dropdown dropdown-menu-end mt-2 py-1">
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z"
                      clip-rule="evenodd"></path>
                  </svg>
                  My Profile
                </a>
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
                      clip-rule="evenodd"></path>
                  </svg>
                  Settings
                </a>


                <div role="separator" class="dropdown-divider my-1"></div>



                <%= link  to: Routes.logout_path(@socket, :delete), method: :delete, class: "dropdown-item d-flex align-items-center" do%>
                <svg class="dropdown-icon text-danger me-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1">
                    </path>
                  </svg>Logout


              <% end %>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <%= live_component assigns.component, id: assigns.component_details.id, details: assigns.component_details %>
    </main>

    </div>
    """
  end
end
