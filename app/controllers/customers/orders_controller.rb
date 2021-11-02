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
    @order = current_customer.orders.new(order_params)
    @order.shipping_fee = 800
    @order.total_payment = @order.shipping_fee.to_i + @sum.to_i
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
    @order = Order.new(order_params)
    if @order.save!
      current_customer.cart_items.each do |cart_item|
        @order_detail = OrderDetail.new(
          order_id: @order.id,
          item_id: cart_item.item_id,
          price: cart_item.item.taxed_price,
          amount: cart_item.amount
          )
      @order_detail.save
      end

      current_customer.cart_items.destroy_all
    end
    redirect_to orders_complete_path
  end

  def complete
  end

  def index
    # @orders = Order.all
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    # @order.shipping_fee = 800
  end

  private
  def order_params
    params.require(:order).permit(:order_id, :customer_id, :payment_method, :postal_code, :address, :name, :delivary_type, :total_payment, :shipping_fee)
  end
end
