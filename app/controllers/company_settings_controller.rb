class CompanySettingsController < ApplicationController
  load_and_authorize_resource
  #/company_settings/new
  def new
  end

  #/company_settings/id/edit
  def edit
  end

  def create
    #Need_Modification
    @company_setting = CompanySetting.new(company_setting_params)
    respond_to do |format|
      if CompanySetting.create_company_setting?(@company_setting)
        format.html { redirect_to @company_setting, notice: 'Company Setting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if CompanySetting.update_company_setting?(@company_setting, company_setting_params)
        format.html { redirect_to dashboard_path, notice: 'Company Settings was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  private 
    def company_setting_params
      params.require(:company_setting).permit(:supervisors_survey_permission, :supervisors_settings_permission, :members_settings_permission, :max_questions, :survey_expiry, :company_id)
    end
end