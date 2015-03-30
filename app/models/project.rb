class Project < ActiveRecord::Base

	belongs_to :user

	has_and_belongs_to_many :project_tags, 
  		class_name: "Tag"
end
