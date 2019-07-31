class CompanySetting < ActiveRecord::Base
  belongs_to :company

  validates :max_questions,
              numericality: { less_than_or_equal_to: 500, greater_than: 0, only_integer: true }

  validates_numericality_of(:survey_expiry_days, greater_than: 0) 
end
