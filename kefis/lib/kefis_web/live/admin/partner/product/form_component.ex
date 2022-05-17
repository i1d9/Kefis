defmodule KefisWeb.Admin.Partner.Product.FormComponent do
  use KefisWeb, :live_component
  alias Kefis.Products


  def update(assigns, socket) do
    {:ok, socket
      |> assign(assigns)
      |> assign(:changeset, Products.change_product(assigns.details.product))
      |> allow_upload(:image,
        accept: ~w(.jpg .jpeg .png),
        max_entries: 1,
        auto_upload: true

      )}
  end


  def render(assigns) do
    ~H"""
    <div>

    <.form let={f} for={@changeset}
    id="product-form"
    phx-target={@myself}
    phx-change="validate"
    phx-submit="save" >

    <%= live_flash(@flash, :info) %>


    <%= label f, :name, for: "name" %>
    <%= text_input f, :name, class: "form-control", id: "name" %>
    <%= error_tag f, :name %>

    <%= label f, :price, for: "name" %>
    <%= number_input f, :price, class: "form-control", id: "price" %>
    <%= error_tag f, :price %>

    <%= label f, :sku %>
    <%= text_input f, :sku, class: "form-control", id: "sku" %>
    <%= error_tag f, :sku %>

    <%= label f, :category, for: "category" %>
    <%= text_input f, :category, class: "form-control", id: "category" %>
    <%= error_tag f, :category %>

    <%= label f, :image %>
    <%= live_file_input @uploads.image, class: "form-control" %>



    <div>
    <%= submit "Save", class: "btn btn-success" %>
    </div>
    </.form>

    </div>

    """
  end


end
