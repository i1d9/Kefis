defmodule KefisWeb.UserView do
  use KefisWeb, :view

  def user_role(role) do
    cond do
      role == "super" ->
        "Admin"
      role == "supplier_admin" ->
          "Supplier"
      role == "supplier_user" ->
          "Supplier"
      role == "retailer_admin" ->
        "Retailer"
      role == "retailer_user" ->
        "Retailer"
      role == "driver" ->
        "Driver"

      true ->
          "Role not set"
    end

  end


end
