class Admins::OrdersController < ApplicationController
  # def index

  # end

  def show
    @order = Order.find(params[:id])
    @item = Item.Customer
  end

  def update
  end


end
