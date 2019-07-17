class Company < ActiveRecord::Base
	belongs_to :subscription_package
	has_one :company_setting
	has_many :groups
	has_many :users
end
