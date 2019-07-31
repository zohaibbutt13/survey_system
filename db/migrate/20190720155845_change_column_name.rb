class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :questions, :type, :question_type
    rename_column :questions, :detail, :statement
    rename_column :surveys, :type, :survey_type
  end
end
