class Group < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :company
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
end
