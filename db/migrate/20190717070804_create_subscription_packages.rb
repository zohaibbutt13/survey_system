class CreateSubscriptionPackages < ActiveRecord::Migration
  def change
    create_table :subscription_packages do |t|
      t.string :subscription_package_name
      t.integer :max_supervisors
      t.integer :max_members

      t.timestamps null: false
    end
  end
end