class Report < ActiveRecord::Base

	belongs_to :reporter,
		class_name: "User"

	belongs_to :reported_user,
		class_name: "User"
end
