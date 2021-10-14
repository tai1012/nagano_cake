class Admins::ItemsController < ApplicationController
  def index
    @items = Item.all
    # @items = Items.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admins_item_path(@item), notice: "商品が新規登録されました"
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admins_item_path(@item), notice: "商品が更新されました"
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end

  def user_block
    if customer_sign_in?
      redirect_to root_path
    end
  end

end