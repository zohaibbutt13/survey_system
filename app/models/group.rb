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
end
