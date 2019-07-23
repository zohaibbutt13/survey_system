class CompanySettingsController < ApplicationController

  #/company_settings/new
  def new
    @company_settings = CompanySetting.new
  end

  #/company_settings/id/edit
  def edit
    @company_settings = CompanySetting.find_by_company_id(params[:id])
  end

  def create
    #Need_Modification
    @company_settings = CompanySetting.new(company_settings_params)
    respond_to do |format|
      if CompanySetting.create_company_settings?(@company_settings)
        format.html { redirect_to @company_settings, notice: 'Company Setting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @company_settings = CompanySetting.find(params[:id])
    respond_to do |format|
      if CompanySetting.update_company_settings?(@company_settings, company_settings_params)
        format.html { redirect_to dashboard_path, notice: 'Company Settings was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  private 
    def company_settings_params
      params.require(:company_setting).permit(:supervisors_survey_permission, :supervisors_settings_permission, :members_settings_permission, :max_questions, :survey_expiry, :company_id)
    end
end