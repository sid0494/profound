class CreateCommendations < ActiveRecord::Migration
  def change
    create_table :commendations do |t|
      t.integer :user_id
      t.integer :commended_user_id
      t.integer :entity_id
      t.string :entity
      t.timestamps null: false
    end

    add_index :commendations, :user_id
  end
end
