class Group < ActiveRecord::Base
  default_scope { where(company_id: Company.current_id) }

  has_many :activities, as: :trackable
  belongs_to :company
  has_and_belongs_to_many :users

  validates :name, presence: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 500 }
  validates_uniqueness_of :name, scope: :company_id

  validates :users, length: {
    minimum: 1,
    message: 'A Group should have at least 1 member'
  }
end
