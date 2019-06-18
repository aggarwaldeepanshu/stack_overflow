 module Concerns::ErrorHandlers
 	extend ::ActiveSupport::Concern

 	def record_not_saved
    flash[:alert] = 'Record not saved'
    redirect_back(fallback_location: root_path)
  end

  def record_not_found
    flash[:alert] = 'Record not found'
    redirect_back(fallback_location: root_path)
  end
 end
