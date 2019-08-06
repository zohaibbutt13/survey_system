class CompanySetting < ActiveRecord::Base
  belongs_to :company

  validates :max_questions, numericality: { less_than_or_equal_to: 500, greater_than: 0, only_integer: true }
  validates :survey_expiry_days, numericality: { greater_than: 0, only_integer: true } 
end