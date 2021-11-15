class Customers::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :admin_block

  def show
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    @customer = @customer.update(customer_params)
    flash[:notice] = "更新しました"
    redirect_to customers_my_page_path
  end

  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def admin_block
    if admin_signed_in?
      redirect_to admins_path
    end
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
