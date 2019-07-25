class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.boolean :status
      t.datetime :cancelled_on
      t.integer :subscription_package_id, index: true

      t.timestamps null: false
    end
  end
end
