module Concerns::Errors
	extend ::ActiveSupport::Concern

	included do
		rescue_from ActiveRecord::RecordInvalid, with: :record_not_saved
		rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
	end
end