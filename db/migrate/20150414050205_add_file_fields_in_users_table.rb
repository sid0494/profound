class AddFileFieldsInUsersTable < ActiveRecord::Migration
  def up
  	add_attachment :users, :resume
  	add_attachment :users, :verification
  end

  def down
  	remove_attachment :users, :resume
  	remove_attachment :users, :verification
  end
end
