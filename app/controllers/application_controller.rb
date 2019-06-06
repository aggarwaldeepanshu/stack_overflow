class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved

  def record_not_saved
    flash[:danger] = 'Record not saved'
    redirect_back
  end
end
