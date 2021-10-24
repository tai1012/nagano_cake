class Customers::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    redirect_to orders_confiramation_path
  end

  def confirmation
    @cart_items = current_customer.cart_items
    @order = current_customer.orders
  end

  def complete
  end

  def create

  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end
end
