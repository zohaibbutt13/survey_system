class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.text :description
      t.string :category
      t.string :image
      t.string :type
      t.datetime :expiry
      t.integer :user_id
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
