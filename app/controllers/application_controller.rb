class ApplicationController < ActionController::Base
  include Concerns::Errors
  include Concerns::ErrorHandlers
  #rescue_from User::NotAuthorized, with: :deny_access

  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_access
    if user_signed_in? == false
      flash[:alert] = 'Please login first'
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:name, :email)
    end
  end
end
