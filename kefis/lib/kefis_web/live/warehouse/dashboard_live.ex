defmodule KefisWeb.Warehouse.DashboardLive do
  use KefisWeb, :live_component

  def update(assigns, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="py-4">

    </div>
    <div class="row">

      <div class="col-12 col-sm-4 col-xl-4 mb-4">
        <div class="card border-0 shadow">
          <div class="card-body">
            <div class="row d-block d-xl-flex align-items-center">
              <div
                class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
                <div class="icon-shape icon-shape-primary rounded me-4 me-sm-0">

                <i class="fa fa-arrow-up" aria-hidden="true"></i>

                </div>
                <div class="d-sm-none">
                  <h2 class="h5">Incoming</h2>
                  <h3 class="fw-extrabold mb-1">345,678</h3>
                </div>
              </div>
              <div class="col-12 col-xl-7 px-xl-0">
                <div class="d-none d-sm-block">
                  <h2 class="h6 text-gray-400 mb-0">Incoming</h2>
                  <h3 class="fw-extrabold mb-2">345k</h3>
                </div>

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

      <div class="col-12 col-sm-4 col-xl-4 mb-4">
      <div class="card border-0 shadow">
        <div class="card-body">
          <div class="row d-block d-xl-flex align-items-center">
            <div
              class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
              <div class="icon-shape icon-shape-secondary rounded me-4 me-sm-0">
              <i class="fa fa-repeat" aria-hidden="true"></i>

              </div>
              <div class="d-sm-none">
                <h2 class="fw-extrabold h5">Processing</h2>
                <h3 class="mb-1">$43,594</h3>
              </div>
            </div>
            <div class="col-12 col-xl-7 px-xl-0">
              <div class="d-none d-sm-block">
                <h2 class="h6 text-gray-400 mb-0">Processing</h2>
                <h3 class="fw-extrabold mb-2">$43,594</h3>
              </div>

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


      <div class="col-12 col-sm-4 col-xl-4 mb-4">
      <div class="card border-0 shadow">
        <div class="card-body">
          <div class="row d-block d-xl-flex align-items-center">
            <div
              class="col-12 col-xl-5 text-xl-center mb-3 mb-xl-0 d-flex align-items-center justify-content-xl-center">
              <div class="icon-shape icon-shape-secondary rounded me-4 me-sm-0">
              <i class="fa fa-arrow-down" aria-hidden="true"></i>

              </div>
              <div class="d-sm-none">
                <h2 class="fw-extrabold h5">Outgoing</h2>
                <h3 class="mb-1">$43,594</h3>
              </div>
            </div>
            <div class="col-12 col-xl-7 px-xl-0">
              <div class="d-none d-sm-block">
                <h2 class="h6 text-gray-400 mb-0">Outgoing</h2>
                <h3 class="fw-extrabold mb-2">$43,594</h3>
              </div>

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
      <div class="col-12 col-xl-12">
        <div class="row">
          <div class="col-12 mb-4">
            <div class="card border-0 shadow">
              <div class="card-header">
                <div class="row align-items-center">
                  <div class="col">
                    <h2 class="fs-5 fw-bold mb-0">Recents</h2>
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
                      <th class="border-bottom" scope="col">Order ID</th>
                      <th class="border-bottom" scope="col">Retailer</th>
                      <th class="border-bottom" scope="col">Products</th>
                      <th class="border-bottom" scope="col">Type  </th>
                      <th class="border-bottom" scope="col">Total</th>
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

    </div>
    </div>
    """
  end
end
