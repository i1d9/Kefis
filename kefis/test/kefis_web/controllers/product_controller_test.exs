defmodule KefisWeb.ProductControllerTest do
  use KefisWeb.ConnCase

  import Kefis.ChainFixtures

  @create_attrs %{category: "some category", image: "some image", name: "some name", price: 42, sku: "some sku"}
  @update_attrs %{category: "some updated category", image: "some updated image", name: "some updated name", price: 43, sku: "some updated sku"}
  @invalid_attrs %{category: nil, image: nil, name: nil, price: nil, sku: nil}

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Products"
    end
  end

  describe "new product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "create product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.product_path(conn, :show, id)

      conn = get(conn, Routes.product_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "edit product" do
    setup [:create_product]

    test "renders form for editing chosen product", %{conn: conn, product: product} do
      conn = get(conn, Routes.product_path(conn, :edit, product))
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "update product" do
    setup [:create_product]

    test "redirects when data is valid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)
      assert redirected_to(conn) == Routes.product_path(conn, :show, product)

      conn = get(conn, Routes.product_path(conn, :show, product))
      assert html_response(conn, 200) =~ "some updated category"
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, Routes.product_path(conn, :delete, product))
      assert redirected_to(conn) == Routes.product_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.product_path(conn, :show, product))
      end
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
