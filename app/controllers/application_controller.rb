class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end
  
  def after_sign_in_path_for(resource)
    # case resource
    # when Admin
    #   admins_path
    # end
    
    if customer_signed_in?
      items_path
      #後で変更
    elsif admin_signed_in?
      admins_path
    else
      root_path
    end
  end
end
