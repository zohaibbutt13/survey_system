class CompanySetting < ActiveRecord::Base
  belongs_to :company

  validates :survey_expiry_days,
              numericality: { less_than_or_equal_to: 5,  only_integer: true }

  validates :max_questions,
              numericality: { less_than_or_equal_to: 500, only_integer: true }
end
