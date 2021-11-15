# frozen_string_literal: true

class Customers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 追記
  def reject_user
    customer = Customer.find_by(email: params[:customer][:email].downcase)
    if customer
      # binding.pry
      if (customer.valid_password?(params[:customer][:password]) && (customer.active_for_authentication? == false))
        flash[:error] = "退会済みです。お手数ですが再度アカウント作成をお願い致します。"
        redirect_to new_customer_session_path
      end
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
