defmodule Kefis.POSTest do
  use Kefis.DataCase

  alias Kefis.POS

  describe "inventories" do
    alias Kefis.POS.Inventory

    import Kefis.POSFixtures

    @invalid_attrs %{margin: nil, quantity: nil}

    test "list_inventories/0 returns all inventories" do
      inventory = inventory_fixture()
      assert POS.list_inventories() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert POS.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      valid_attrs = %{margin: 42, quantity: 42}

      assert {:ok, %Inventory{} = inventory} = POS.create_inventory(valid_attrs)
      assert inventory.margin == 42
      assert inventory.quantity == 42
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = POS.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      update_attrs = %{margin: 43, quantity: 43}

      assert {:ok, %Inventory{} = inventory} = POS.update_inventory(inventory, update_attrs)
      assert inventory.margin == 43
      assert inventory.quantity == 43
    end

    test "update_inventory/2 with invalid data returns error changeset" do
      inventory = inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = POS.update_inventory(inventory, @invalid_attrs)
      assert inventory == POS.get_inventory!(inventory.id)
    end

    test "delete_inventory/1 deletes the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{}} = POS.delete_inventory(inventory)
      assert_raise Ecto.NoResultsError, fn -> POS.get_inventory!(inventory.id) end
    end

    test "change_inventory/1 returns a inventory changeset" do
      inventory = inventory_fixture()
      assert %Ecto.Changeset{} = POS.change_inventory(inventory)
    end
  end

  describe "sales" do
    alias Kefis.POS.Sale

    import Kefis.POSFixtures

    @invalid_attrs %{sale_date: nil}

    test "list_sales/0 returns all sales" do
      sale = sale_fixture()
      assert POS.list_sales() == [sale]
    end

    test "get_sale!/1 returns the sale with given id" do
      sale = sale_fixture()
      assert POS.get_sale!(sale.id) == sale
    end

    test "create_sale/1 with valid data creates a sale" do
      valid_attrs = %{sale_date: ~D[2022-05-02]}

      assert {:ok, %Sale{} = sale} = POS.create_sale(valid_attrs)
      assert sale.sale_date == ~D[2022-05-02]
    end

    test "create_sale/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = POS.create_sale(@invalid_attrs)
    end

    test "update_sale/2 with valid data updates the sale" do
      sale = sale_fixture()
      update_attrs = %{sale_date: ~D[2022-05-03]}

      assert {:ok, %Sale{} = sale} = POS.update_sale(sale, update_attrs)
      assert sale.sale_date == ~D[2022-05-03]
    end

    test "update_sale/2 with invalid data returns error changeset" do
      sale = sale_fixture()
      assert {:error, %Ecto.Changeset{}} = POS.update_sale(sale, @invalid_attrs)
      assert sale == POS.get_sale!(sale.id)
    end

    test "delete_sale/1 deletes the sale" do
      sale = sale_fixture()
      assert {:ok, %Sale{}} = POS.delete_sale(sale)
      assert_raise Ecto.NoResultsError, fn -> POS.get_sale!(sale.id) end
    end

    test "change_sale/1 returns a sale changeset" do
      sale = sale_fixture()
      assert %Ecto.Changeset{} = POS.change_sale(sale)
    end
  end

  describe "sale_details" do
    alias Kefis.POS.SaleDetail

    import Kefis.POSFixtures

    @invalid_attrs %{price: nil, quantity: nil, total: nil}

    test "list_sale_details/0 returns all sale_details" do
      sale_detail = sale_detail_fixture()
      assert POS.list_sale_details() == [sale_detail]
    end

    test "get_sale_detail!/1 returns the sale_detail with given id" do
      sale_detail = sale_detail_fixture()
      assert POS.get_sale_detail!(sale_detail.id) == sale_detail
    end

    test "create_sale_detail/1 with valid data creates a sale_detail" do
      valid_attrs = %{price: 42, quantity: 42, total: 42}

      assert {:ok, %SaleDetail{} = sale_detail} = POS.create_sale_detail(valid_attrs)
      assert sale_detail.price == 42
      assert sale_detail.quantity == 42
      assert sale_detail.total == 42
    end

    test "create_sale_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = POS.create_sale_detail(@invalid_attrs)
    end

    test "update_sale_detail/2 with valid data updates the sale_detail" do
      sale_detail = sale_detail_fixture()
      update_attrs = %{price: 43, quantity: 43, total: 43}

      assert {:ok, %SaleDetail{} = sale_detail} = POS.update_sale_detail(sale_detail, update_attrs)
      assert sale_detail.price == 43
      assert sale_detail.quantity == 43
      assert sale_detail.total == 43
    end

    test "update_sale_detail/2 with invalid data returns error changeset" do
      sale_detail = sale_detail_fixture()
      assert {:error, %Ecto.Changeset{}} = POS.update_sale_detail(sale_detail, @invalid_attrs)
      assert sale_detail == POS.get_sale_detail!(sale_detail.id)
    end

    test "delete_sale_detail/1 deletes the sale_detail" do
      sale_detail = sale_detail_fixture()
      assert {:ok, %SaleDetail{}} = POS.delete_sale_detail(sale_detail)
      assert_raise Ecto.NoResultsError, fn -> POS.get_sale_detail!(sale_detail.id) end
    end

    test "change_sale_detail/1 returns a sale_detail changeset" do
      sale_detail = sale_detail_fixture()
      assert %Ecto.Changeset{} = POS.change_sale_detail(sale_detail)
    end
  end
end
