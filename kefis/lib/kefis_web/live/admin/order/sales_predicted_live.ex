defmodule KefisWeb.Admin.Order.SalesPredicted do
  use KefisWeb, :live_component

  alias Kefis.Orders
  alias Kefis.ModelPredictor, as: ML

  alias Contex.{BarChart, Plot, Dataset}

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_total_sales()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  def render(assigns) do
    ~H"""
    <div>
        <%= @chart_svg %>
    </div>

    """
  end

  defp assign_total_sales(socket) do
    orders = Orders.total_orders()

    IO.inspect(ML.predict([[20, 30, 40]]))

    socket
    |> assign(:total_sales, [
      {"Total Orders", Orders.total_orders()},
      {"Predicted", 2.5714285714285716}
    ])
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket
    |> assign(
      :chart,
      dataset
      |> Contex.BarChart.new()
      |> Contex.BarChart.colours(:warm)
    )
  end

  defp assign_dataset(%{assigns: %{total_sales: total_sales}} = socket) do
    socket
    |> assign(:dataset, Contex.Dataset.new(total_sales))
  end

  defp assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
    socket
    |> assign(
      :chart_svg,
      Plot.new(500, 400, chart)
      |> Plot.titles("Projection ", "")
      |> Plot.axis_labels("Month", "KES")
      |> Plot.to_svg()
    )
  end
end
