class Discussion < ActiveRecord::Base

	belongs_to :owner,
		class_name: "User"

	has_many :discussion_replies,
		dependent: :destroy

	has_and_belongs_to_many :discussion_tags,
		class_name: "Tag"
end
