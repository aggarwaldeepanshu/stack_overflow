class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved

  before_action :configure_permitted_parameters, if: :devise_controller?

  def record_not_saved
    flash[:danger] = 'Record not saved'
    redirect_back
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])

    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:name, :email)
    end
  end

end
