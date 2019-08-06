class AddGroupidToSurvey < ActiveRecord::Migration
  def change
    add_reference :surveys, :group, index: true
  end
end
