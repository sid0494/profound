class CreateDiscussionsTagsJoinTable < ActiveRecord::Migration
  def up
  	create_table :discussions_tags, id: false do |t|
  		t.integer :discussion_id
  		t.integer :tag_id
  	end

  	add_index :discussions_tags, ["discussion_id", "tag_id"]
  end

  def down
  	drop_table :discussions_tags  	
  end
end
