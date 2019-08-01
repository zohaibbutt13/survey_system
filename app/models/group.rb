class Group < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :company
  has_and_belongs_to_many :users
  has_many :surveys, dependent: :destroy, inverse_of: :group

  validates :name, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :users, length: {
    minimum: 1,
    message: 'A Group should have at least 1 member'
  }
  validate :same_name_within_company

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
end
