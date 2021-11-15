class Admins::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def update
    # 一つなので単数系に修正
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order
    # .any?でも代用可
    if @order.order_details.where(product_status: 2).present?
      @order.update(order_status: 2)
    end
    if @order.order_details.all? {
      |order_detail| order_detail.product_status == 3}
      @order.update(order_status: 3)
    end
    flash[:notice] = "ステータスが変更されました"
    redirect_back(fallback_location: root_path)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:product_status)
  end

  def user_block
    if customer_signed_in?
      redirect_to root_path
    end
  end
end

