class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :company_id, index: true
      t.string :parameters
      t.string :action

      t.timestamps null: false
    end
  end
end
