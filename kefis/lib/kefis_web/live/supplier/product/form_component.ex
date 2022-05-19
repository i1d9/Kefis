defmodule KefisWeb.Supplier.Product.FormComponent do
  use KefisWeb, :live_component
  alias Kefis.Chain.Product
  alias Kefis.Chain
  alias Kefis.Products

  @impl true
  def update(%{details: %{product: product, supplier: supplier} = details}, socket) do
    correct_product =
      if(product.id == nil or product.partner_id == supplier.id, do: true, else: false)

    {:ok,
     socket
     |> assign(details)
     |> assign(correct: correct_product)
     |> assign(:changeset, Products.change_product(details.product))
     |> allow_upload(:image,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1,
       auto_upload: true
     )}
  end

  @impl true
  def handle_event("validate", %{"product" => product}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.live_action, product_params)
  end

  defp save_product(socket, :new_product, product_params) do
    case uploaded_entries(socket, :image) do
      {[_ | _] = entries, []} ->
        upload_supplier_product_image = upload_supplier_product_image(socket, entries)

        product_params =
          Map.put(product_params, "image", Enum.at(upload_supplier_product_image, 0))

        case Products.create(socket.assigns.supplier, product_params) do
          {:ok, product} ->
            IO.inspect(product)
            {:noreply, socket}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, :changeset, changeset)}
        end

      _ ->
        {:noreply, socket}
    end
  end

  defp save_product(socket, :edit_product, product_params) do
    case uploaded_entries(socket, :image) do
      {[_ | _] = entries, []} ->
        upload_supplier_product_image = upload_supplier_product_image(socket, entries)

        product_params =
          Map.put(product_params, "image", Enum.at(upload_supplier_product_image, 0))

        case Products.update(socket.assigns.supplier, product_params) do
          {:ok, product} ->
            IO.inspect(product)
            {:noreply, socket}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, :changeset, changeset)}
        end

      _ ->
        IO.inspect(socket.assigns.product)
        IO.inspect(product_params)

        case Products.update(socket.assigns.product, product_params) do
          {:ok, product} ->
            {:noreply,
             socket
             |> assign(:product, product)}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:noreply, assign(socket, :changeset, changeset)}
        end
    end
  end

  defp upload_supplier_product_image(socket, entries) do
    uploaded_files =
      for entry <- entries do
        _file_path =
          consume_uploaded_entry(socket, entry, fn %{path: path} ->
            dest = Path.join("priv/static/uploads/products", Path.basename(path))
            File.cp!(path, dest)
            Routes.static_path(socket, "/uploads/products/#{Path.basename(dest)}")
          end)
      end

    uploaded_files
  end
end
