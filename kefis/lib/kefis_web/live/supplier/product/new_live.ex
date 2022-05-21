defmodule KefisWeb.Supplier.Product.NewLive do
  use KefisWeb, :live_view

  alias Kefis.Products
  alias Kefis.Chain.Product

  def mount(_params, _session, socket) do
    changeset = Product.changeset(%Product{}, %{})

    {:ok,
     socket
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])}
  end

  def handle_event("save", %{"product" => product_params}, _socket) do
    IO.inspect(product_params)
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
end
