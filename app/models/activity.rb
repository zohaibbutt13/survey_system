class Activity < ActiveRecord::Base
  serialize :parameters
  belongs_to :company
  belongs_to :trackable, polymorphic: true
  belongs_to :owner, class_name: 'User'

  validates_presence_of :action, :company_id, :owner_id,
                        :trackable_id, :trackable_type

  scope :user_activities, -> (user_id) { where("owner_id = ?", user_id) }
  scope :company_activities, -> (company_id) { where("company_id = ?", company_id) }

  def self.get_user_activities(user)
    if user.present?
      if user.role == 'member'
        activities = member_activities(user)
      elsif user.role == 'supervisor'
        activities = supervisor_activities(user)
      elsif user.role == 'admin'
        activities = admin_activities(user)
      end
    end
    activities ||= []
  end

  def self.member_activities(user)
    Activity.user_activities(user.id)
  end

  def self.supervisor_activities(user)
    Activity.user_activities(user.id)
  end

  def self.admin_activities(user)
    Activity.company_activities(user.company_id)
  end
end
