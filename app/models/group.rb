class Group < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :users, length: {
    minimum: 1,
    message: 'A Group should have at least 1 member'
  }

  def create_group(company_id)
    company = Company.find(company_id)
    save
  end

  def update_group(params)
    company = Company.update_attributes(params)
    save
  end
end
