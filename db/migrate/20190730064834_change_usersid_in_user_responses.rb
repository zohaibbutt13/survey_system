class ChangeUsersidInUserResponses < ActiveRecord::Migration
  def change
    rename_column :user_responses, :users_id, :user_id
  end
end
