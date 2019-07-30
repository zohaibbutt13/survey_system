class ChangeResponsesToAnswers < ActiveRecord::Migration
  def change
    rename_table :responses, :answers
  end
end
