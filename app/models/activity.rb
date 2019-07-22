class Activity < ActiveRecord::Base
  belongs_to :company
  belongs_to :trackable, :polymorphic => true
  belongs_to :owner, class_name: 'User'

  validates_presence_of :action, :company_id, :owner_id,
                        :trackable_id, :trackable_type

  # Returns array of activities corresponding to given user_id
  def self.get_user_activity(user_id)
    @activities = Array[]
    Activity.where(owner_id: user_id).find_each do |activity|
      @activities.push(activity)
    end
    @activities
  end

  # Returns array of activities corresponding to given company_id
  # Response activites are displayed if response is set to true
  def self.get_company_activity(company_id, response = false)
    @activities = Array[]
    if response
      Activity.where(company_id: company_id).find_each do |activity|
        @activities.push(activity)
      end
    else
      Activity.where("company_id = company_id AND trackable_type != 'response'").find_each do |activity|
        @activities.push(activity)
      end
    end
    @activities
  end
end
