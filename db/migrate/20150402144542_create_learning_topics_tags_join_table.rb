class CreateLearningTopicsTagsJoinTable < ActiveRecord::Migration
  def up
  	create_table :learning_topics_tags, id: false do |t|
  		t.integer :learning_topic_id
  		t.integer :tag_id
  	end

  	add_index :learning_topics_tags, ["learning_topic_id", "tag_id"]
  end

  def down
  	drop_table :learning_topics_tags  	
  end
end
