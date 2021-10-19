class Customers::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @sum = 0
    @cart_items.each do |cart_item|
      @subtotal = (Item.find(cart_item.item_id).taxed_price* cart_item.amount).to_i
      @sum += @subtotal
    end
  end

  def create

    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save

    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @customer = Customer.find(current_customer.id)
    @cart_items = current_customer.cart_items
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      flash[:notice] = "カート内の商品を削除しました。"
      redirect_to cart_items_path
    else
      @customer = Customer.find(current_customer.id)
      render :index
    end
  end
  
  def destroy_all
    customer = Customer.find(current_customer.id)
    customer.cart_items.destroy_all
    flash[:notice] = "カート内の商品を全て削除しました。"
    redirect_to cart_items_path
    # else
    #   @customer = Customer.find(current_customer.id)
    #   render :index
    # end
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end
end
