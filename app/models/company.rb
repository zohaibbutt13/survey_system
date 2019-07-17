class Company < ActiveRecord::Base
	belongs_to :subscription_package
	has_one :company_setting
	has_many :groups
	has_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 } 

end
