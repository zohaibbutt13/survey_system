class Group < ActiveRecord::Base
  default_scope { where(company_id: Company.current_id) }

  has_many :activities, as: :trackable
  belongs_to :company
  has_and_belongs_to_many :users

  validates :name, 
            presence: { message: 'Name must not be blank.' },
            length: { maximum: 150,
                      message: 'Name must not have more than 150 characters.' }
  validates :description,
            presence: { message: 'Name must not be blank.' },
            length: { maximum: 500, 
                      message: 'Description must not have more than 500 characters.' } 
  validates_uniqueness_of :name, scope: :company_id,
                          message: 'Group name must be unique.'
  validates :users, length: {
    minimum: 1,
    message: 'A Group should have at least 1 member'
  }
end
