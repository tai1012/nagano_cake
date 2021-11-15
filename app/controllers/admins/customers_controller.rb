class Admins::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_block

  def index
    @customers = Customer.all
    @customers = @customers.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admins_customer_path(@customer)
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana,
    :first_name_kana, :postal_code, :address, :telephone_number, :is_active)
  end
  def user_block
    if customer_signed_in?
      redirect_to root_path
    end
  end

end
