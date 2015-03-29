class CreateAreasOfInterestJoinTable < ActiveRecord::Migration
  def up
  	create_table :areas_of_interest, id: false do |t|
      t.string :tag_id
      t.integer :user_id
    end

    add_index :areas_of_interest, ["tag_id", "user_id"]
  end

  def down
  	drop_table :areas_of_interest
  end
end
