class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :reported_ones, ->{ User.where(:id => (User.all.select{|u| u.self_reports.count > 10}.map(&:id)))}

  has_many :projects, dependent: :destroy

  has_and_belongs_to_many :project_applications,
      class_name: "Project",
      join_table: "project_applications"

  has_and_belongs_to_many :interest_areas, 
  		class_name: "Tag", 
  		join_table: "areas_of_interest",
      dependent: :destroy 

  has_and_belongs_to_many :expertise_areas, 
  		class_name: "Tag", 
  		join_table: "areas_of_expertise",
      dependent: :destroy

  has_many :discussions,
      foreign_key: "owner_id",
      dependent: :destroy

  has_many :discussion_replies, dependent: :destroy 

  has_many :learning_topics,
      foreign_key: "owner_id",
      dependent: :destroy

  has_many :follower_follows,
      foreign_key: "following_id",
      class_name: "Follow",
      dependent: :destroy

  has_many :followers,
      through:  :follower_follows,
      source: :follower

  has_many :following_follows,
      foreign_key: "follower_id",
      class_name: "Follow",
      dependent: :destroy

  has_many :followings,
      through: :following_follows,
      source: :following

  has_many :notifications

  has_and_belongs_to_many :shared_projects,
      class_name: "Project",
      join_table: "shared_projects_users",
      dependent: :destroy

  has_many :conversations, 
      :foreign_key => :sender_id,
      dependent: :destroy

  has_attached_file :resume
  validates_attachment_file_name :resume, :matches => [/pdf\Z/]
  validates_attachment :resume, :size => { :in => 0..10.megabytes }

  has_attached_file :verification
  validates_attachment_file_name :verification, :matches => [/pdf\Z/]
  validates_attachment :verification, :size => { :in => 0..10.megabytes }

  validates :username, uniqueness: true

  has_many :reports,
      class_name: "Report",
      foreign_key: "reporter_id",
      dependent: :destroy

  has_many :self_reports,
      class_name: "Report",
      foreign_key: "reported_id",
      dependent: :destroy

  has_and_belongs_to_many :voted_replies,
      class_name: "DiscussionReply",
      join_table: "voting",
      dependent: :destroy

  has_many :commendations,
      dependent: :destroy
end
