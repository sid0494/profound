class CreateDiscussionReplies < ActiveRecord::Migration
  def change
    create_table :discussion_replies do |t|
      t.integer :discussion_id
      t.string :user_id
      t.string :reply
      t.float :upvotes
      t.float :downvotes

      t.timestamps null: false
    end
  end
end
