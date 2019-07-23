class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.text :detail
      t.integer :question_id, index: true
      t.integer :company_id, index: true

      t.timestamps null: false
    end
  end
end
