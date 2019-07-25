class Activity < ActiveRecord::Base
  belongs_to :company
  belongs_to :trackable, polymorphic: true
  belongs_to :owner, class_name: 'User'

  validates_presence_of :action, :company_id, :owner_id,
                        :trackable_id, :trackable_type

  scope :user_activities, ->(user_id) { where("owner_id = ?", user_id) }
  scope :company_activities, ->(company_id) { where("company_id = ?", company_id) }

  def self.get_user_activities(user)
    user ||= { id: 3, role: 'admin', company_id: 1 }
    if user[:role] == 'member' || user[:role] == 'supervisor'
      activities = Activity.user_activities(user[:id])
    elsif user[:role] == 'admin'
      activities = Activity.company_activities(user[:company_id])
    end
  end
end