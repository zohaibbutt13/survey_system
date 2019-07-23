class CompanySetting < ActiveRecord::Base
  belongs_to :company

  def self.create_company_settings?(company_settings_object)
    company_settings_object.save
  end

  def self.update_company_settings?(company_settings_object, company_settings_params)
    company_settings_object.update(company_settings_params)
  end
end