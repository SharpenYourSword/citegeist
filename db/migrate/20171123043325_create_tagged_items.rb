class CreateTaggedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :tagged_items do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :tag_id
      t.timestamps
    end
  end
end
