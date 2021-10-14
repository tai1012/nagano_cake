class Admins::HomesController < ApplicationController
  def top
    @orders = Order.all
    # @order = Order.find(params[:id])
    
  end
  
  # def top_detail
  # end
end
