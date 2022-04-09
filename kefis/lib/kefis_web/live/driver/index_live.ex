defmodule KefisWeb.Driver.IndexLive do
  use KefisWeb, :live_component

  def update(_assigns, socket) do
    {:ok ,socket}
  end

  def render(assigns) do
    ~H"""
    <div>

    <div class="row">



      <div class="col-12 col-sm-6 col-xl-6 mb-6">
        <div class="card border-0 shadow">
          <div class="card-body">
            <div class="row d-block d-xl-flex align-items-center">
              <div
                class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">
                  <svg class="icon" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path
                      d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z">
                    </path>
                  </svg>
                </div>
                <div class="d-sm-none">
                  <h2 class="h5">Deliveries</h2>
                  <h3 class="fw-extrabold mb-1">345,678</h3>
                </div>
              </div>
              <div class="col-12 col-xl-7 px-xl-0">
                <div class="d-none d-sm-block">
                  <h2 class="h6 text-gray-400 mb-0">Deliveries</h2>
                  <h3 class="fw-extrabold mb-2">345k</h3>
                </div>
                <small class="d-flex align-items-center text-gray-500">
                  Feb 1 - Apr 1,
                  <svg class="icon icon-xxs text-gray-500 ms-2 me-1" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zM4.332 8.027a6.012 6.012 0 011.912-2.706C6.512 5.73 6.974 6 7.5 6A1.5 1.5 0 019 7.5V8a2 2 0 004 0 2 2 0 011.523-1.943A5.977 5.977 0 0116 10c0 .34-.028.675-.083 1H15a2 2 0 00-2 2v2.197A5.973 5.973 0 0110 16v-2a2 2 0 00-2-2 2 2 0 01-2-2 2 2 0 00-1.668-1.973z"
                      clip-rule="evenodd"></path>
                  </svg>
                  USA
                </small>
                <div class="small d-flex mt-1">
                  <div>Since last month <svg class="icon icon-xs text-success" fill="currentColor" viewBox="0 0 20 20"
                      xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd"
                        d="M14.707 12.707a1 1 0 01-1.414 0L10 9.414l-3.293 3.293a1 1 0 01-1.414-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 010 1.414z"
                        clip-rule="evenodd"></path>
                    </svg><span class="text-success fw-bolder">22%</span></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-12 col-sm-6 col-xl-6 mb-6">
        <div class="card border-0 shadow">
          <div class="card-body">
            <div class="row d-block d-xl-flex align-items-center">
              <div
                class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                <div class="icon-shape icon-shape-secondary rounded me-4 me-sm-0">
                  <svg class="icon" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M10 2a4 4 0 00-4 4v1H5a1 1 0 00-.994.89l-1 9A1 1 0 004 18h12a1 1 0 00.994-1.11l-1-9A1 1 0 0015 7h-1V6a4 4 0 00-4-4zm2 5V6a2 2 0 10-4 0v1h4zm-6 3a1 1 0 112 0 1 1 0 01-2 0zm7-1a1 1 0 100 2 1 1 0 000-2z"
                      clip-rule="evenodd"></path>
                  </svg>
                </div>
                <div class="d-sm-none">
                  <h2 class="fw-extrabold h5">Collections</h2>
                  <h3 class="mb-1">$43,594</h3>
                </div>
              </div>
              <div class="col-12 col-xl-7 px-xl-0">
                <div class="d-none d-sm-block">
                  <h2 class="h6 text-gray-400 mb-0">Collections</h2>
                  <h3 class="fw-extrabold mb-2">$43,594</h3>
                </div>
                <small class="d-flex align-items-center text-gray-500">
                  Feb 1 - Apr 1,
                  <svg class="icon icon-xxs text-gray-500 ms-2 me-1" fill="currentColor" viewBox="0 0 20 20"
                    xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zM4.332 8.027a6.012 6.012 0 011.912-2.706C6.512 5.73 6.974 6 7.5 6A1.5 1.5 0 019 7.5V8a2 2 0 004 0 2 2 0 011.523-1.943A5.977 5.977 0 0116 10c0 .34-.028.675-.083 1H15a2 2 0 00-2 2v2.197A5.973 5.973 0 0110 16v-2a2 2 0 00-2-2 2 2 0 01-2-2 2 2 0 00-1.668-1.973z"
                      clip-rule="evenodd"></path>
                  </svg>
                  GER
                </small>
                <div class="small d-flex mt-1">
                  <div>Since last month <svg class="icon icon-xs text-danger" fill="currentColor" viewBox="0 0 20 20"
                      xmlns="http://www.w3.org/2000/svg">
                      <path fill-rule="evenodd"
                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                        clip-rule="evenodd"></path>
                    </svg><span class="text-danger fw-bolder">2%</span></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
    <div class="row">
      <div class="col-12 col-xl-8">
        <div class="row">
          <div class="col-12 mb-4">
            <div class="card border-0 shadow">
              <div class="card-header">
                <div class="row align-items-center">
                  <div class="col">
                    <h2 class="fs-5 fw-bold mb-0">Page visits</h2>
                  </div>
                  <div class="col text-end">
                    <a href="#" class="btn btn-sm btn-primary">See all</a>
                  </div>
                </div>
              </div>
              <div class="table-responsive">
                <table class="table align-items-center table-flush">
                  <thead class="thead-light">
                    <tr>
                      <th class="border-bottom" scope="col">Page name</th>
                      <th class="border-bottom" scope="col">Page Views</th>
                      <th class="border-bottom" scope="col">Page Value</th>
                      <th class="border-bottom" scope="col">Bounce rate</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <th class="text-gray-900" scope="row">
                        /demo/admin/index.html
                      </th>
                      <td class="fw-bolder text-gray-500">
                        3,225
                      </td>
                      <td class="fw-bolder text-gray-500">
                        $20
                      </td>
                      <td class="fw-bolder text-gray-500">
                        <div class="d-flex">
                          <svg class="icon icon-xs text-danger me-2" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M5.293 7.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 5.414V17a1 1 0 11-2 0V5.414L6.707 7.707a1 1 0 01-1.414 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          42,55%
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="text-gray-900" scope="row">
                        /demo/admin/forms.html
                      </th>
                      <td class="fw-bolder text-gray-500">
                        2,987
                      </td>
                      <td class="fw-bolder text-gray-500">
                        0
                      </td>
                      <td class="fw-bolder text-gray-500">
                        <div class="d-flex">
                          <svg class="icon icon-xs text-success me-2" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M14.707 12.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 14.586V3a1 1 0 012 0v11.586l2.293-2.293a1 1 0 011.414 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          43,24%
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="text-gray-900" scope="row">
                        /demo/admin/util.html
                      </th>
                      <td class="fw-bolder text-gray-500">
                        2,844
                      </td>
                      <td class="fw-bolder text-gray-500">
                        294
                      </td>
                      <td class="fw-bolder text-gray-500">
                        <div class="d-flex">
                          <svg class="icon icon-xs text-success me-2" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M14.707 12.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 14.586V3a1 1 0 012 0v11.586l2.293-2.293a1 1 0 011.414 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          32,35%
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="text-gray-900" scope="row">
                        /demo/admin/validation.html
                      </th>
                      <td class="fw-bolder text-gray-500">
                        2,050
                      </td>
                      <td class="fw-bolder text-gray-500">
                        $147
                      </td>
                      <td class="fw-bolder text-gray-500">
                        <div class="d-flex">
                          <svg class="icon icon-xs text-danger me-2" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M5.293 7.707a1 1 0 010-1.414l4-4a1 1 0 011.414 0l4 4a1 1 0 01-1.414 1.414L11 5.414V17a1 1 0 11-2 0V5.414L6.707 7.707a1 1 0 01-1.414 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          50,87%
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <th class="text-gray-900" scope="row">
                        /demo/admin/modals.html
                      </th>
                      <td class="fw-bolder text-gray-500">
                        1,483
                      </td>
                      <td class="fw-bolder text-gray-500">
                        $19
                      </td>
                      <td class="fw-bolder text-gray-500">
                        <div class="d-flex">
                          <svg class="icon icon-xs text-success me-2" fill="currentColor" viewBox="0 0 20 20"
                            xmlns="http://www.w3.org/2000/svg">
                            <path fill-rule="evenodd"
                              d="M14.707 12.293a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 111.414-1.414L9 14.586V3a1 1 0 012 0v11.586l2.293-2.293a1 1 0 011.414 0z"
                              clip-rule="evenodd"></path>
                          </svg>
                          26,12%
                        </div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>


        </div>
      </div>
      <div class="col-12 col-xl-4">
        <div class="col-12 px-0 mb-4">
          <div class="card border-0 shadow">
            <div class="card-header d-flex flex-row align-items-center flex-0 border-bottom">
              <div class="d-block">
                <div class="h6 fw-normal text-gray mb-2">Total orders</div>
                <h2 class="h3 fw-extrabold">452</h2>
                <div class="small mt-2">
                  <span class="fas fa-angle-up text-success"></span>
                  <span class="text-success fw-bold">18.2%</span>
                </div>
              </div>
              <div class="d-block ms-auto">
                <div class="d-flex align-items-center text-end mb-2">
                  <span class="dot rounded-circle bg-gray-800 me-2"></span>
                  <span class="fw-normal small">July</span>
                </div>
                <div class="d-flex align-items-center text-end">
                  <span class="dot rounded-circle bg-secondary me-2"></span>
                  <span class="fw-normal small">August</span>
                </div>
              </div>
            </div>
            <div class="card-body p-2">
              <div class="ct-chart-ranking ct-golden-section ct-series-a"></div>
            </div>
          </div>
        </div>


      </div>
    </div>
    <div class="theme-settings card bg-gray-800 pt-2 collapse" id="theme-settings">
      <div class="card-body bg-gray-800 text-white pt-4">
        <button type="button" class="btn-close theme-settings-close" aria-label="Close" data-bs-toggle="collapse"
          href="#theme-settings" role="button" aria-expanded="false" aria-controls="theme-settings"></button>
        <div class="d-flex justify-content-between align-items-center mb-3">
          <p class="m-0 mb-1 me-4 fs-7">Open source <span role="img" aria-label="gratitude">💛</span></p>
          <a class="github-button" href="https://github.com/themesberg/volt-bootstrap-5-dashboard"
            data-color-scheme="no-preference: dark; light: light; dark: light;" data-icon="octicon-star"
            data-size="large" data-show-count="true"
            aria-label="Star themesberg/volt-bootstrap-5-dashboard on GitHub">Star</a>
        </div>
        <a href="https://themesberg.com/product/admin-dashboard/volt-bootstrap-5-dashboard" target="_blank"
          class="btn btn-secondary d-inline-flex align-items-center justify-content-center mb-3 w-100">
          Download
          <svg class="icon icon-xs ms-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd"
              d="M2 9.5A3.5 3.5 0 005.5 13H9v2.586l-1.293-1.293a1 1 0 00-1.414 1.414l3 3a1 1 0 001.414 0l3-3a1 1 0 00-1.414-1.414L11 15.586V13h2.5a4.5 4.5 0 10-.616-8.958 4.002 4.002 0 10-7.753 1.977A3.5 3.5 0 002 9.5zm9 3.5H9V8a1 1 0 012 0v5z"
              clip-rule="evenodd"></path>
          </svg>
        </a>
        <p class="fs-7 text-gray-300 text-center">Available in the following technologies:</p>
        <div class="d-flex justify-content-center">
          <a class="me-3" href="https://themesberg.com/product/admin-dashboard/volt-bootstrap-5-dashboard"
            target="_blank">
            <img src="../../assets/img/technologies/bootstrap-5-logo.svg" class="image image-xs">
          </a>
          <a href="https://demo.themesberg.com/volt-react-dashboard/#/" target="_blank">
            <img src="../../assets/img/technologies/react-logo.svg" class="image image-xs">
          </a>
        </div>
      </div>
    </div>

    <div class="card theme-settings bg-gray-800 theme-settings-expand" id="theme-settings-expand">
      <div class="card-body bg-gray-800 text-white rounded-top p-3 py-2">
        <span class="fw-bold d-inline-flex align-items-center h6">
          <svg class="icon icon-xs me-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd"
              d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
              clip-rule="evenodd"></path>
          </svg>
          Settings
        </span>
      </div>
    </div>
    </div>
    """
  end
end
