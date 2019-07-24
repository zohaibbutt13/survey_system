class CompanySetting < ActiveRecord::Base
  belongs_to :company

  def self.create_company_setting?(company_setting_object)
    company_setting_object.save
  end

  def self.update_company_setting?(company_setting_object, company_setting_params)
    company_setting_object.update(company_setting_params)
  end
end