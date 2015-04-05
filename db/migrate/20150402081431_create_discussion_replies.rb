class CreateDiscussionReplies < ActiveRecord::Migration
  def change
    create_table :discussion_replies do |t|
      t.integer :discussion_id
      t.string :user_id
      t.string :reply
      t.integer :upvotes, :default => 0
      t.integer :downvotes, :default => 0

      t.timestamps null: false
    end
  end
end
