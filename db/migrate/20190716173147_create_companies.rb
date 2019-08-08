class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :status
      t.datetime :cancelled_on
      t.integer :subscription_package_id

      t.timestamps null: false
    end
  end
end