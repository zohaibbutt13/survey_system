class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :emails_subscription
      t.boolean :show_graphs
      t.boolean :show_history
      t.integer :company_id
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
