class Group < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :users, length: {
    minimum: 1,
    message: 'A group should have at least 1 members'
  }
end
