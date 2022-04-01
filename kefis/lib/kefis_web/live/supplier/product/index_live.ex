defmodule KefisWeb.Supplier.Product.IndexLive do
  use KefisWeb, :live_view

  alias Kefis.Repo
  alias Kefis.Products

  def mount(_params, %{"partner" => partner, "user" => user} = _session, socket) do
    partner = Repo.preload partner, :products

    IO.inspect(partner.products)

    products = partner.products

    page_entries = 10
    paginated_products = products |> Enum.chunk_every(page_entries)
    products_for_page = paginated_products |> Enum.at(0)
    total_entries = products |> Enum.count()
    total_pages = paginated_products |> Enum.count()

    {:ok,
    socket
    |> assign(:user, user)
    |> assign(:products, products)
    |> assign(:total_pages, total_pages)
    |> assign(:total_entries, total_entries)
    |> assign(:page_number, 0)
    |> assign(:page_size, 0)
    |> assign(:current_page, 0)
    |> assign(:paginated_products, paginated_products)
    |> assign(:products_for_page, products_for_page)
    |> assign(:page_entries, page_entries)

    }
  end



  def handle_event("change_page", %{"index" => index} =  _params, %{assigns: %{paginated_products: paginated_products }} = socket) do


    products_for_page = paginated_products |> Enum.at(String.to_integer(index))
    page_entries = products_for_page |> Enum.count()

    {:noreply,
    socket
    |> assign(:page_number, String.to_integer(index))
    |> assign(:products_for_page, products_for_page)
    |> assign(:page_entries, page_entries)


    }
  end


  def handle_event("next", _params, %{assigns: %{page_number: page_number, paginated_products: paginated_products  }} = socket) do


    products_for_page = paginated_products |> Enum.at(page_number + 1)
    page_entries = products_for_page |> Enum.count()

    {:noreply,
    socket
    |> assign(:page_number, page_number + 1)
    |> assign(:products_for_page, products_for_page)
    |> assign(:page_entries, page_entries)
    }
  end

  def handle_event("previous", _params, %{assigns: %{page_number: page_number, paginated_products: paginated_products  }} = socket) do


    products_for_page = paginated_products |> Enum.at(page_number - 1)
    page_entries = products_for_page |> Enum.count()

    {:noreply,
    socket
    |> assign(:page_number, page_number - 1)
    |> assign(:products_for_page, products_for_page)
    |> assign(:page_entries, page_entries)
    }
  end

  def handle_event("delete_product",%{"id" => id} = value, socket) do
    #Products.delete()

    case Products.delete(String.to_integer(id)) do
      {:ok, _product} ->
        {:noreply, socket}
      {:error, _error} ->
        {:noreply, socket}
    end

  end

  def handle_event("edit_product", _value, socket) do
    {:noreply,
    socket}
  end





end
