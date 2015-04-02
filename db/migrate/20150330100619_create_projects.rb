class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.belongs_to :user, index: true
      t.string :project_name, null: false
      t.string :project_status, default: "ongoing"
      t.string :project_description
      t.timestamps null: false
    end
  end

  def down
  	drop_table :projects
  end
end
