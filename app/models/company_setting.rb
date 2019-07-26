class CompanySetting < ActiveRecord::Base
  belongs_to :company

  validates :survey_expiry_days,
              numericality: { less_than_or_equal_to: 5,  only_integer: true }

  validates :max_questions,
              numericality: { less_than_or_equal_to: 500, only_integer: true }          

  def create_company_setting?
    save
  end

  def update_company_setting(company_setting_params)
    update(company_setting_params)
  end
end