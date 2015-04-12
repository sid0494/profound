class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :type
      t.integer :type_id
      t.integer :optional_id
      t.integer :user_id
      t.boolean :read, default: false

      t.timestamps null: false
    end

    add_index :notifications, :user_id
  end
end
