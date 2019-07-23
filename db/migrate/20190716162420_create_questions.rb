class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :detail
      t.string :type
      t.integer :survey_id, index: true
      t.integer :company_id, index: true
      
      t.timestamps null: false
    end
  end
end
