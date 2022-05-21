defmodule KefisWeb.Driver.TripsLive do
  use KefisWeb, :live_view

  alias Kefis.Drivers

  def mount(params, %{"user" => user} = _session, socket) do
    IO.puts("Params 1")
    IO.inspect(params)

    {:ok,
     socket
     |> assign(:user, user)
     |> init_items(user.driver, "collection")}
  end

  defp init_items(socket, driver, type) do
    items =
      case type do
        "collection" ->
          Drivers.driver_collection(driver)

        "delivery" ->
          Drivers.driver_deliveries(driver)
      end

    page_entries = 10
    paginated_items = items |> Enum.chunk_every(page_entries)
    items_for_page = paginated_items |> Enum.at(0)
    total_entries = items |> Enum.count()
    total_pages = paginated_items |> Enum.count()

    socket
    |> assign(:items, items)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_items, paginated_items)
    |> assign(:items_for_page, items_for_page)
    |> assign(:page_entries, page_entries)
  end

  def handle_params(%{"type" => type} = params, _url, socket) do
    IO.inspect("Params 2")
    IO.inspect(params)

    case type do
      "collection" ->
        IO.puts("Display Collections")

      "delivery" ->
        IO.puts("Display Delivery")
    end

    {:noreply,
     socket
     |> assign(:type, type)}
  end

  def handle_event(
        "change_page",
        %{"index" => index} = _params,
        %{assigns: %{paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(String.to_integer(index))
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, String.to_integer(index))
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "next",
        _params,
        %{assigns: %{page_number: page_number, paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(page_number + 1)
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number + 1)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end

  def handle_event(
        "previous",
        _params,
        %{assigns: %{page_number: page_number, paginated_items: paginated_items}} = socket
      ) do
    items_for_page = paginated_items |> Enum.at(page_number - 1)
    page_entries = items_for_page |> Enum.count()

    {:noreply,
     socket
     |> assign(:page_number, page_number - 1)
     |> assign(:items_for_page, items_for_page)
     |> assign(:page_entries, page_entries)}
  end
end
