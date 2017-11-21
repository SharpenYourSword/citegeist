class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
	t.string :name
	t.boolean :active, :default => true
	t.timestamps
    end
  end
end
