class Project < ActiveRecord::Base

	belongs_to :user

	has_and_belongs_to_many :applicants,
		class_name: "User",
		join_table: "project_applications"

	has_and_belongs_to_many :project_tags, 
  		class_name: "Tag"
end
