class CreateSharedProjectsUsersJoinTable < ActiveRecord::Migration
  def up
  	create_table :shared_projects_users, id: false do |t|
  		t.integer :project_id
  		t.integer :user_id
  	end

  	add_index :shared_projects_users, ["project_id", "user_id"]
  end

  def down
  	drop_table :shared_projects_users
  end
end
