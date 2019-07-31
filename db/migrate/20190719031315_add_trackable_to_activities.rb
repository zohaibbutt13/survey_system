class AddTrackableToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :trackable, polymorphic: true, index: true
  end
end
