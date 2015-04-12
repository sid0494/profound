class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :body
      t.references :conversation, index: true
      t.references :user, index: true
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
