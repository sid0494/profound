class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps null: false
    end

    add_index :messages, :sender_id
    add_index :messages, :receiver_id
    
  end
end
