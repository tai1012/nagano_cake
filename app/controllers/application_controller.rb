class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end

  def after_sign_in_path_for(resource)
    if customer_signed_in?
      root_path
    elsif admin_signed_in?
      admins_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    elsif resource == :customer
      root_path
    else
      root_path
    end
  end
end
