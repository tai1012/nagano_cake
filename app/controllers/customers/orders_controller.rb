class Customers::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    case params[:delivary_type]
    when "0" then
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "1" then 
      @address = Address.find(params[:order][:select_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else 
      current_user.addresses.create!(
        postal_code: @order.postal_code,
        address: @order.address,
        name: @order.name
      )
    end
    @order.save
    redirect_to orders_confiramation_path(@order)
  end

  def confirmation
    @cart_items = current_customer.cart_items
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    case params[:delivary_type]
    when "0" then
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when "1" then 
      @address = Address.find(params[:order][:select_address])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    else 
      current_customer.addresses.create!(
        postal_code: @order.postal_code,
        address: @order.address,
        name: @order.name
      )
    end
    @order.save
    redirect_to orders_confirmation_path(@order)
  end

  def complete
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
