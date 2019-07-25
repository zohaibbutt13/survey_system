class Company < ActiveRecord::Base
  belongs_to :subscription_package
  has_one :company_setting
  has_many :groups
  has_many :users
  has_many :group_members
  has_many :surveys
  has_many :questions
  has_many :options
  has_many :responses
  has_many :user_settings

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  def dashboard_resources(user,company)
    user_setting = user.user_setting
    company_setting = company.company_setting
    return company_setting, user_setting
  end 
end
