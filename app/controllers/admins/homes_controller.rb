class Admins::HomesController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block
  
  def top
    @orders = Order.all
    @orders = @orders.page(params[:page]).reverse_order.per(10)
  end
    
  
  # def top_detail
  # end
  private
  def user_block
    if customer_signed_in?
      redirect_to root_path
    end
  end
end
