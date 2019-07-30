class CompanySettingsController < ApplicationController
  load_and_authorize_resource
  #/company_settings/new
  def new
  end

  #/company_settings/id/edit
  def edit
  end

  def create
    respond_to do |format|
      if @company_setting.create_company_setting
        flash[:notice] = "Company settings was successfully created."
        format.html { redirect_to @company_setting }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @company_setting.update_company_setting(company_setting_params)
        flash[:notice] = "Company settings was successfully updated."
        format.html { redirect_to dashboard_path }
      else
        format.html { render :edit }
      end
    end
  end
  
  private 
    def company_setting_params
      params.require(:company_setting).permit(:supervisors_survey_permission, :supervisors_settings_permission, :members_settings_permission, :max_questions, :survey_expiry_days)
    end
end