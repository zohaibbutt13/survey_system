class Group < ActiveRecord::Base
  default_scope { where(company_id: Company.current_id) }

  has_many :activities, as: :trackable
  belongs_to :company
  has_and_belongs_to_many :users
  has_many :surveys

  validates :name, presence: true,
            length: { maximum: 150, message: 'must not have more than 150 characters.' }
  validates :description, presence: true,
            length: { maximum: 500, message: 'must not have more than 500 characters.' } 
  validates_uniqueness_of :name, scope: :company_id
  validates :users, length: {
    minimum: 1,
    message: 'in a group must be more than 1.'
  }
  validate :same_name_within_company

  after_create :create_group_activity
  after_update :update_group_activity
  after_destroy :destroy_group_activity

  def same_name_within_company
    if Group.find_by(name: name, company: company) != nil
      errors.add(:name, 'group name must be unique')
    end
  end

  def create_group(company_id)
    company = Company.find(company_id)
    save
  end

  def update_group(params)
    company = Company.update_attributes(params)
    save
  end

  def group_admin_id
    User.where("role = ? AND company_id = ?", 'admin', company_id).first.id
  end

  def create_group_activity
    Activity.create(trackable: self, action: 'created', owner_id: group_admin_id, company_id: company_id)
  end

  def update_group_activity
    Activity.create(trackable: self, action: 'updated', owner_id: group_admin_id, company_id: company_id)
  end

  def destroy_group_activity
    Activity.create(trackable: self, action: 'deleted', owner_id: group_admin_id, company_id: company_id)
  end
end
