class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :answer
      t.integer :question_id
      t.belongs_to :question, index: true
      t.belongs_to :company, index: true

      t.timestamps null: false
    end
  end
end
