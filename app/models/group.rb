class Group < ActiveRecord::Base
  default_scope { where(company_id: Company.current_id) }

  has_many :activities, as: :trackable
  belongs_to :company
  has_and_belongs_to_many :users
  has_many :surveys

  validates :name, presence: true, uniqueness: true,
            length: { maximum: 150, message: 'must not have more than 150 characters.' }
  validates :description, presence: true,
            length: { maximum: 500, message: 'must not have more than 500 characters.' } 
  validates :users, length: {
    minimum: 1,
    message: 'in a group must be at least 1.'
  }

  after_create :create_group_activity
  after_update :update_group_activity
  after_destroy :destroy_group_activity

  def create_group_activity
    Activity.create(trackable: self, action: 'created', owner_id: created_by_id, company_id: company_id, parameters: { trackable_name: name })
  end

  def update_group_activity
    Activity.create(trackable: self, action: 'updated', owner_id: created_by_id, company_id: company_id, parameters: { trackable_name: name })
  end

  def destroy_group_activity
    Activity.create(trackable: self, action: 'deleted', owner_id: created_by_id, company_id: company_id, parameters: { trackable_name: name })
  end
end
