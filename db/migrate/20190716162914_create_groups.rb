class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.integer :company_id
      t.belongs_to :company, index: true

      t.timestamps null: false
    end
  end
end
