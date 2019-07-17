class Group < ActiveRecord::Base
	belongs_to :company
	has_many :group_members
end
