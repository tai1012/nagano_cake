class Customers::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
    # @addresses = Address.all
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: "配送先を登録しました。"
    else
      flash[:error] = "未入力です"
      render :index
    end
  end

  def edit
    @address = current_customer.addresses.find(params[:id])
    # @address = current_customer.addresses.find(params[:id])
  end

  def update
    @address = current_customer.addresses.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path(@address), notice: "配送先情報を変更しました。"
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
