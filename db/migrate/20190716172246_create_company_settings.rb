class CreateCompanySettings < ActiveRecord::Migration
  def change
    create_table :company_settings do |t|
      t.integer :max_questions
      t.boolean :supervisors_survey_permission
      t.boolean :supervisors_settings_permission
      t.boolean :members_settings_permission
      t.integer :survey_expiry_days
      t.integer :company_id, index: true

      t.timestamps null: false
    end
  end
end
