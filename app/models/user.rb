class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :interest_areas, 
  		class_name: "Tag", 
  		join_table: "areas_of_interest" 

  has_and_belongs_to_many :expertise_areas, 
  		class_name: "Tag", 
  		join_table: "areas_of_expertise"

  has_many :sent_messages,
      class_name: "Message",
      foreign_key: "sender_id"

  has_many :received_messages,
      class_name: "Message",
      foreign_key: "receiver_id" 
end
