class DiscussionReply < ActiveRecord::Base

	belongs_to :discussion

	belongs_to :user

	has_and_belongs_to_many :voters,
		class_name: "User",
		join_table: "voting",
		dependent: :destroy
end
