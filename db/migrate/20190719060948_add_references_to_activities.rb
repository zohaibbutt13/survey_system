class AddReferencesToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :owner, references: :users
  end
end
