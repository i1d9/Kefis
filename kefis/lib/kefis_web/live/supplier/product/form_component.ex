defmodule KefisWeb.Supplier.Product.FormComponent do
  use KefisWeb, :live_component


  alias Kefis.Chain.Product



  @impl true
  def update(%{ changeset: changeset} = assigns, socket) do

    {:ok, socket
      |> assign(assigns)
      |> assign(:changeset, changeset)
      |> allow_upload(:image,
        accept: ~w(.jpg .jpeg .png),
        max_entries: 1,
        auto_upload: true

      )}
  end



  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      Product.changeset(%Product{}, product_params)
      |> Map.put(:action, :validate)


    {:noreply, assign(socket, :changeset, changeset)}
  end




  def handle_event("save", %{"product" => product_params}  = _params, socket) do

    IO.inspect(product_params)
    case uploaded_entries(socket, :image) do
      {[_|_] = entries, []} ->


        uploaded_files = for entry <- entries do
          file_path =
            consume_uploaded_entry(socket, entry, fn %{path: path} ->
              dest = Path.join(Kefis.product_uploads_priv_dir(), Path.basename(path))

              IO.inspect(entry)
              IO.inspect(path)
              File.cp!(path, dest)
              Routes.static_path(socket, "#{Kefis.product_uploads_priv_dir()}/#{Path.basename(dest)}")


            end)

          product = Map.put(product_params, :image, file_path)
          IO.inspect(product)
          IO.inspect(file_path)
        end
        {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

      _ ->

        {:noreply, socket}
    end
  end


  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :image, ref)}
  end

  defp handle_progress(:image, entry, socket) do
    # :timer.sleep(1000)
    if entry.done? do
      path =
        consume_uploaded_entry(
          socket,
          entry,
          &upload_static_file(&1, socket)
        )

      {:noreply,
       socket
       |> put_flash(:info, "file #{entry.client_name} uploaded")
       |> update_changeset(:image, path)}
    else
      {:noreply, socket}
    end
  end

  def update_changeset(%{assigns: %{changeset: changeset}} = socket, key, value) do
    socket
    |> assign(:changeset, Ecto.Changeset.put_change(changeset, key, value))
  end

  defp save_product(socket, :edit, product_params) do
    case Catalog.update_product(socket.assigns.product, product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    case Catalog.create_product(product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp upload_static_file(%{path: path}, socket) do
    # Plug in your production image file persistence implementation here!
    dest = Path.join(Kefis.product_uploads_priv_dir(), Path.basename(path))
    File.cp!(path, dest)

    IO.inspect(dest)
    Routes.static_path(socket, "/images/#{Path.basename(dest)}")
  end

  def upload_image_error(%{image: %{errors: errors}}, entry) when length(errors) > 0 do
    {_, msg} =
      Enum.find(errors, fn {ref, _} ->
        ref == entry.ref || ref == entry.upload_ref
      end)

    upload_error_msg(msg)
  end

  def upload_image_error(_, _), do: ""

  defp upload_error_msg(:not_accepted) do
    "Invalid file type"
  end

  defp upload_error_msg(:too_many_files) do
    "Too many files"
  end

  defp upload_error_msg(:too_large) do
    "File exceeds max size"
  end

end
