class AddColumnsToAnswers < ActiveRecord::Migration
  def change
    add_reference :answers, :user_response, index: true
    add_reference :answers, :option, index: true
  end
end
