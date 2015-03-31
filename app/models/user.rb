class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects

  has_and_belongs_to_many :project_applications,
      class_name: "Project",
      join_table: "project_applications"

  has_and_belongs_to_many :interest_areas, 
  		class_name: "Tag", 
  		join_table: "areas_of_interest" 

  has_and_belongs_to_many :expertise_areas, 
  		class_name: "Tag", 
  		join_table: "areas_of_expertise"  
end
