class AddCompanyIdToUserResponses < ActiveRecord::Migration
  def change
  	add_column :user_responses, :company_id, :integer
  end
end
