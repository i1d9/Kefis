defmodule KefisWeb.Admin.ShellDashboardLive do
  use KefisWeb, :live_component

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  def handle_event("test_target", _value, socket) do
    IO.inspect("socket")
    {:noreply, socket}
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
              alt="#{@user.first_name} #{@user.second_name}">
          </div>
          <div class="d-block">
            <h2 class="h5 mb-3">Hi, <%= @user.first_name %> <%= @user.second_name %></h2>


            <%= link  to: Routes.logout_path(@socket, :delete), method: :delete, class: "btn btn-secondary btn-sm d-inline-flex align-items-center" do%>
            <svg class="icon icon-xxs me-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"
            xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
          </svg>

          Sign Out
            <%end%>

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

      <li class="nav-item  active ">

      <%= link "Dashboard", to: Routes.live_path(@socket, KefisWeb.Admin.IndexLive), class: "sidebar-text" %>


      </li>

              <li class="nav-item">


              <%= link to: Routes.index_path(@socket, :retailer), class: "nav-link d-flex justify-content-between" do%>
        <span>
                      <span class="sidebar-icon">

                          <i class="fas fa-store"></i>

                      </span>
                      <span class="sidebar-text">Retailers</span>
                  </span>
        <% end %>


          </li>
          <li class="nav-item">

        <%= link to: Routes.index_path(@socket, :supplier), class: "nav-link d-flex justify-content-between" do%>
        <span>
                      <span class="sidebar-icon">

                          <i class="fa-solid fa-industry"></i>

                      </span>
                      <span class="sidebar-text">Suppliers</span>
                  </span>
        <% end %>

        <li class="nav-item">

        <%= link to: Routes.index_path(@socket, :index), class: "nav-link d-flex justify-content-between" do%>
        <span>
                                <span class="sidebar-icon">

                                    <i class="fa-solid fa-store"></i>

                                </span>
                                <span class="sidebar-text">Orders</span>
                            </span>
        <% end %>



                    </li>


          </li>


          <li class="nav-item">


          <%= link to: Routes.index_path(@socket, :list), class: "nav-link d-flex justify-content-between" do%>
          <span>
                                  <span class="sidebar-icon">
          <i class="fa fa-truck" aria-hidden="true"></i>

                                  </span>
                                  <span class="sidebar-text">Warehouses</span>
                              </span>
          <% end %>




                      </li>



                      <li class="nav-item">


                      <%= link to: Routes.index_path(@socket, :transaction_index), class: "nav-link d-flex justify-content-between" do%>
                      <span>
                                              <span class="sidebar-icon">
                                                  <i class="fas fa-user"></i>

                                              </span>
                                              <span class="sidebar-text">Transactions</span>
                                          </span>
                      <% end %>




                                  </li>

                  <li class="nav-item">


                  <%= link to: Routes.live_path(@socket, KefisWeb.Admin.User.IndexLive), class: "nav-link d-flex justify-content-between" do%>
                  <span>
                                          <span class="sidebar-icon">
                                              <i class="fas fa-user"></i>

                                          </span>
                                          <span class="sidebar-text">Users</span>
                                      </span>
                  <% end %>




                              </li>
                              <li class="nav-item">
                              <a href="https://demo.themesberg.com/volt-pro/pages/map.html" target="_blank"
                                  class="nav-link d-flex justify-content-between">
                                  <span>
                                      <span class="sidebar-icon">


               <i class='fa-solid fa-map'></i>
                                      </span>
                                      <span class="sidebar-text">Map</span>
                                  </span>
                                  <span>
                                      <span class="badge badge-sm bg-success ms-1 text-gray-800"></span>
                                  </span>
                              </a>
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

            <!-- / Search form -->
          </div>
          <!-- Navbar links -->
          <ul class="navbar-nav align-items-center">


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
                <a class="dropdown-item d-flex align-items-center" href="#">
                  <svg class="dropdown-icon text-gray-400 me-2" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M5 3a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2V5a2 2 0 00-2-2H5zm0 2h10v7h-2l-1 2H8l-1-2H5V5z"
                      clip-rule="evenodd"></path>
                  </svg>
                  Messages
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
