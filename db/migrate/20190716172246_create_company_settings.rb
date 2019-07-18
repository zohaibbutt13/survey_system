class CreateCompanySettings < ActiveRecord::Migration
  def change
    create_table :company_settings do |t|
      t.integer :max_questions
      t.boolean :is_sup_create_surv
      t.boolean :is_sup_edit_surv
      t.boolean :is_my_settings_sup
      t.boolean :is_my_settings_memb
      t.time :survey_expiry
      t.integer :company_id
      t.belongs_to :company, index: true

      t.timestamps null: false
    end
  end
end
