class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :questions, :type, :question_type
    rename_column :questions, :detail, :statement
  end
end
