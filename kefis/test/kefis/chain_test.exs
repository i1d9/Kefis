defmodule Kefis.ChainTest do
  use Kefis.DataCase

  alias Kefis.Chain

  describe "suppliers" do
    alias Kefis.Chain.Supplier

    import Kefis.ChainFixtures

    @invalid_attrs %{contact_email: nil, contact_phone: nil, lat: nil, lng: nil, location: nil, name: nil, phone: nil}

    test "list_suppliers/0 returns all suppliers" do
      supplier = supplier_fixture()
      assert Chain.list_suppliers() == [supplier]
    end

    test "get_supplier!/1 returns the supplier with given id" do
      supplier = supplier_fixture()
      assert Chain.get_supplier!(supplier.id) == supplier
    end

    test "create_supplier/1 with valid data creates a supplier" do
      valid_attrs = %{contact_email: "some contact_email", contact_phone: "some contact_phone", lat: 120.5, lng: 120.5, location: "some location", name: "some name", phone: "some phone"}

      assert {:ok, %Supplier{} = supplier} = Chain.create_supplier(valid_attrs)
      assert supplier.contact_email == "some contact_email"
      assert supplier.contact_phone == "some contact_phone"
      assert supplier.lat == 120.5
      assert supplier.lng == 120.5
      assert supplier.location == "some location"
      assert supplier.name == "some name"
      assert supplier.phone == "some phone"
    end

    test "create_supplier/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chain.create_supplier(@invalid_attrs)
    end

    test "update_supplier/2 with valid data updates the supplier" do
      supplier = supplier_fixture()
      update_attrs = %{contact_email: "some updated contact_email", contact_phone: "some updated contact_phone", lat: 456.7, lng: 456.7, location: "some updated location", name: "some updated name", phone: "some updated phone"}

      assert {:ok, %Supplier{} = supplier} = Chain.update_supplier(supplier, update_attrs)
      assert supplier.contact_email == "some updated contact_email"
      assert supplier.contact_phone == "some updated contact_phone"
      assert supplier.lat == 456.7
      assert supplier.lng == 456.7
      assert supplier.location == "some updated location"
      assert supplier.name == "some updated name"
      assert supplier.phone == "some updated phone"
    end

    test "update_supplier/2 with invalid data returns error changeset" do
      supplier = supplier_fixture()
      assert {:error, %Ecto.Changeset{}} = Chain.update_supplier(supplier, @invalid_attrs)
      assert supplier == Chain.get_supplier!(supplier.id)
    end

    test "delete_supplier/1 deletes the supplier" do
      supplier = supplier_fixture()
      assert {:ok, %Supplier{}} = Chain.delete_supplier(supplier)
      assert_raise Ecto.NoResultsError, fn -> Chain.get_supplier!(supplier.id) end
    end

    test "change_supplier/1 returns a supplier changeset" do
      supplier = supplier_fixture()
      assert %Ecto.Changeset{} = Chain.change_supplier(supplier)
    end
  end

  describe "partners" do
    alias Kefis.Chain.Partner

    import Kefis.ChainFixtures

    @invalid_attrs %{contact_email: nil, contact_phone: nil, lat: nil, lng: nil, location: nil, name: nil, phone: nil, type: nil}

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Chain.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Chain.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      valid_attrs = %{contact_email: "some contact_email", contact_phone: "some contact_phone", lat: 120.5, lng: 120.5, location: "some location", name: "some name", phone: "some phone", type: "some type"}

      assert {:ok, %Partner{} = partner} = Chain.create_partner(valid_attrs)
      assert partner.contact_email == "some contact_email"
      assert partner.contact_phone == "some contact_phone"
      assert partner.lat == 120.5
      assert partner.lng == 120.5
      assert partner.location == "some location"
      assert partner.name == "some name"
      assert partner.phone == "some phone"
      assert partner.type == "some type"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chain.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      update_attrs = %{contact_email: "some updated contact_email", contact_phone: "some updated contact_phone", lat: 456.7, lng: 456.7, location: "some updated location", name: "some updated name", phone: "some updated phone", type: "some updated type"}

      assert {:ok, %Partner{} = partner} = Chain.update_partner(partner, update_attrs)
      assert partner.contact_email == "some updated contact_email"
      assert partner.contact_phone == "some updated contact_phone"
      assert partner.lat == 456.7
      assert partner.lng == 456.7
      assert partner.location == "some updated location"
      assert partner.name == "some updated name"
      assert partner.phone == "some updated phone"
      assert partner.type == "some updated type"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Chain.update_partner(partner, @invalid_attrs)
      assert partner == Chain.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Chain.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Chain.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Chain.change_partner(partner)
    end
  end
end
