class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_name, limit: 30

      t.timestamps null: false
    end
    add_index :tags, :tag_name, unique: true
  end
end
