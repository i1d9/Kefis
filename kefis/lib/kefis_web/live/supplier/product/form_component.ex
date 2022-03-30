defmodule KefisWeb.Supplier.Product.FormComponent do
  use KefisWeb, :live_component


  alias Kefis.Chain.Product


  def update(%{ changeset: changeset} = assign, socket) do
    {
      :ok,
      socket
      |> assign(:changeset, changeset)
    }
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



  def update_changeset(%{assigns: %{changeset: changeset}} = socket, key, value) do
    socket
    |> assign(:changeset, Ecto.Changeset.put_change(changeset, key, value))
  end

  defp upload_static_file(%{path: path}, socket) do
    # Plug in your production image file persistence implementation here!
    dest = Path.join("priv/static/images", Path.basename(path))
    File.cp!(path, dest)
    Routes.static_path(socket, "/images/#{Path.basename(dest)}")
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
       |> update_changeset(:image_upload, path)}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Product.changeset(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, _socket) do
    IO.inspect(product_params)
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
       |> update_changeset(:image_upload, path)}
    else
      {:noreply, socket}
    end
  end

end
