class Customers::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = current_customer.addresses
  end

  def confirm
    @cart_items = current_customer.cart_items
    @sum = 0
      @cart_items.each do |cart_item|
        @subtotal = (Item.find(cart_item.item_id).taxed_price* cart_item.amount).to_i
        @sum += @subtotal
    end
    @total = 800 + @sum
    @order = Order.new(order_params)
    if params[:delivery_type] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:delivery_type] == "1"
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

  end

  def create
  end

  def complete
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :delivary_type)
  end

end
