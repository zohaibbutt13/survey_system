class AddCreatedByIdToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :created_by_id, :integer
  end
end
