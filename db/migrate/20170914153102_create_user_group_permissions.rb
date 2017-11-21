class CreateUserGroupPermissions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_group_permissions do |t|
        t.integer :user_group_id
	t.string :permission
      t.timestamps
    end
    add_index :user_group_permissions, :user_group_id
  end
end
