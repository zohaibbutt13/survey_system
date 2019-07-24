class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :answer
      t.integer :question_id, index: true

      t.timestamps null: false
    end
  end
end
