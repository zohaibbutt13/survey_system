class CompanySetting < ActiveRecord::Base
  belongs_to :company

  def create_company_setting
    save
  end

  def update_company_setting(company_setting_params)
    update(company_setting_params)
  end
end