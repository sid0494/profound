class CreateLearningTopics < ActiveRecord::Migration
  def change
    create_table :learning_topics do |t|
      t.string :topic_name
      t.string :description
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
