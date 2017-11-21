class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
	t.string :email
	t.string :password_digest
	t.string :remember_token
	t.string :password_reset_token
	t.timestamp :password_reset_sent_at

	t.boolean :global_admin, :default => false
	t.boolean :active, :default => true

	t.timestamps
    end
  end
end
