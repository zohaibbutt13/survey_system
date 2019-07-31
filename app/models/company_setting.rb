class CompanySetting < ActiveRecord::Base
  belongs_to :company

  validates :max_questions, numericality: { less_than_or_equal_to: 500, only_integer: true }
  validate :same_name_within_company

  def same_name_within_company
    if Group.find_by(name: name, company: company) != nil # present
      errors.add(:name, 'group name must be unique')
    end
  end          
end
