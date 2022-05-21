defmodule KefisWeb.Retailer.Transaction.TransactComponent do
  use KefisWeb, :live_component

  alias Kefis.Accounts
  alias Kefis.Repo
  alias Kefis.Chain.Transaction

  def update(%{retailer: retailer} = assigns, socket) do
    retailer = retailer |> Repo.preload(:account)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:account, retailer.account)
     |> assign(:balance, retailer.account.balance)
     |> assign(:input_amount, 0)
     |> assign(:phone_number, 0)}
  end

  def render_content(assigns, "deposit") do
    ~H"""
    <div class="card border-0 ">
    <div class="card-body">
      <h1>Deposit</h1>

      <p>
      Balance KES <%= @balance %>
      </p>
      <div class="row align-items-center justify-content-center">
      <%= form_for :mpesa, "#", [phx_change: "amount_change", phx_target: @myself], fn f -> %>
        <div class="input-group mb-3">
        <%= number_input f, :amount, placeholder: "Amount", min: 15, class: "form-control" %>
        <%= error_tag f, :amount %>
        </div>


        <div>

      </div>
      <% end %>

      <%= form_for :mpesa, "#", [phx_change: "phone_change", phx_target: @myself], fn f -> %>



      <div class="input-group mb-3">

      <%= text_input f, :phone, placeholder: "M-Pesa Number", class: "form-control" %>
      </div>

      <div>
      <%= submit "Deposit", phx_click: "save_deposit", phx_target: @myself, type: "button", class: "btn btn-success" %>
    </div>
    <% end %>
    </div>
    </div>
    </div>
    """
  end

  def handle_event("save_deposit", _value, socket) do
    IO.inspect(socket)

    case Accounts.deposit(socket.assigns.account, socket.assigns.input_amount) do
      {:ok, transaction} ->
        IO.inspect(transaction)

        {:noreply,
         socket
         |> redirect(to: Routes.orders_path(socket, :list_my_transaction))}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_event("save_withdraw", _value, socket) do
    IO.inspect(socket)

    case Accounts.withdraw(socket.assigns.account, socket.assigns.input_amount) do
      {:ok, transaction} ->
        IO.inspect(transaction)

        {:noreply,
         socket
         |> redirect(to: Routes.orders_path(socket, :list_my_transaction))}

      {:error, _} ->
        {:noreply, socket}
    end
  end

  def handle_event("amount_change", %{"mpesa" => %{"amount" => amount}}, socket) do
    if socket.assigns.type == "withdraw" do
      if socket.assigns.account.balance - String.to_integer(amount) >= 0 do
        {:noreply,
         socket
         |> assign(:input_amount, String.to_integer(amount))
         |> assign(:balance, socket.assigns.account.balance - String.to_integer(amount))}
      else
        {:noreply, socket}
      end
    else
      if String.to_integer(amount) >= 10 do
        {:noreply,
         socket
         |> assign(:input_amount, String.to_integer(amount))
         |> assign(:balance, socket.assigns.account.balance + String.to_integer(amount))}
      else
        {:noreply, socket}
      end
    end
  end

  def handle_event("phone_change", %{"mpesa" => %{"phone" => phone}}, socket) do
    {:noreply,
     socket
     |> assign(:phone_number, phone)}
  end

  def render_content(assigns, "withdraw") do
    ~H"""
    <div class="card border-0 ">
    <div class="card-body">
      <h1>Withdraw</h1>

      <p>
      Balance KES <%= @balance %>
      </p>
      <div class="row align-items-center justify-content-center">
      <%= form_for :mpesa, "#", [phx_change: "amount_change", phx_target: @myself], fn f -> %>
        <div class="input-group mb-3">
        <%= number_input f, :amount, placeholder: "Amount", min: 15, class: "form-control" %>

        </div>
        <%= submit "Withdraw", phx_click: "save_withdraw", phx_target: @myself, type: "button", class: "btn btn-success" %>



        <div>

      </div>
      <% end %>


    </div>
    </div>
    </div>
    """
  end

  def render_content(assigns, _) do
    ~H"""
    <div>dssdkj</div>
    """
  end

  def render(assigns) do
    ~H"""
    <div>
      <%= render_content(assigns, @type) %>

    </div>
    """
  end
end
