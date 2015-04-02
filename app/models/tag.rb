class Tag < ActiveRecord::Base

	has_and_belongs_to_many :interested_users,
		class_name: "User",
  		join_table: "areas_of_interest"

  	has_and_belongs_to_many :expert_users,
  		class_name: "User",
  		join_table: "areas_of_expertise"

  	has_and_belongs_to_many :discussions

  	has_and_belongs_to_many :projects
  	
end