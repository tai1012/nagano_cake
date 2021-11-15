class Customers::ItemsController < ApplicationController
  def index
    @items_count = Item.all.order(id: "DESC")
    @items = @items_count.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    if current_customer.present?
      items = current_customer.cart_items

      if items.find_by(item_id: @item.id).present?
        @cart_item = items.find_by(item_id: @item.id)
      else
        @cart_item = items.new(item_id: @item.id)
      end
    end
  end

  def active_products
    Item.joins(:genre).where(genres:{is_active:true})
  end

  def user_cart_items
    if current_customer.present?
      @cart_items = current_customer.cart_items
    end
  end

end
