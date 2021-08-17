class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about, :public_action]
  before_action :configure_permitted_parameters,if: :devise_controller?

 def after_sign_out_path_for(resource)
      root_path
 end

 def after_sign_in_path_for(resource)
	  user_path(resource)
 end




  protected

  def configure_permitted_parameters
    added_attrs = [:user_name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
