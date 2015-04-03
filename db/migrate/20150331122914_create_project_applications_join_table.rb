class CreateProjectApplicationsJoinTable < ActiveRecord::Migration
  def up
  	create_table :project_applications, id: false do |t|
  		t.integer :project_id
  		t.integer :user_id
  	end

  	add_index :project_applications, ["project_id", "user_id"]
  end

  def down
  	drop_table :project_applications
  end
end
