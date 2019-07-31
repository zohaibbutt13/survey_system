class Company < ActiveRecord::Base
  belongs_to :subscription_package
  has_one :company_setting, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :surveys, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :options, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :user_settings, dependent: :destroy
  has_many :activities, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 } 
  validates :subdomain, presence: true, uniqueness: true, length: { maximum: 30 }

  def self.current_id=(id)
    Thread.current[:tenant_id] = id
  end

  def self.current_id
    Thread.current[:tenant_id]
  end

  # def create_company(Params)
  #   company = Company.new(params)
  #   company.save
  # end
end
