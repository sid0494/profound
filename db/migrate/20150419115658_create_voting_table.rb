class CreateVotingTable < ActiveRecord::Migration
  def up
    create_table :voting do |t|
    	t.integer :discussion_reply_id
    	t.integer :user_id
    end

    add_index :voting, ["discussion_reply_id", "user_id"]
  end

  def down
  	drop_table :voting
  end
end
