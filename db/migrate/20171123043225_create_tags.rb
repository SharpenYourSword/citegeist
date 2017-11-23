class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.integer :group_id
      t.integer :parent_tag_id
      t.text :name
      t.timestamps
    end
  end
end
