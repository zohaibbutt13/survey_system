class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :company
      t.string :parameters
      t.string :action

      t.timestamps null: false
    end
  end
end
