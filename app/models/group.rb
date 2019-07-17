class Group < ActiveRecord::Base
	belongs_to :company
	has_many :group_members

   validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }
end
