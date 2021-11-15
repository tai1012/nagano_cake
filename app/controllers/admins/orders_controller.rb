class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  # def index
  #   # @orders = Order.all
  #   # @customer = Customer.find(params[:customer_id])
  #   # @orders = @customer.orders.page(params[:page]).reverse_order.per(10)
  #   # @order = Order.all.find_by(customer_id: params[:customer_id])
  #   # @orders = @order.page(params[:page]).reverse_order.per(10)
  # end

  def show
    @order = Order.find(params[:id])
    # @item = Item.Customer
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == 1
      @order.order_details.each do |order_detail|
        order_detail.update(product_status: 1)
      end
    end
    flash[:notice] = "ステータスが更新されました"
    redirect_to admins_order_path(@order)
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

  def user_block
    if customer_signed_in?
      redirect_to root_path
    end
  end
end
