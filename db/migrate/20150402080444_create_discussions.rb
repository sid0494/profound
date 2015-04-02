class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :topic_name
      t.string :description
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
