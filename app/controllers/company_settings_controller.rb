class CompanySettingsController < ApplicationController
  load_and_authorize_resource

  #/company_settings/id/edit
  def edit
  end

  def update
    respond_to do |format|
      if @company_setting.update(company_setting_params)
        flash[:notice] = "Company settings was successfully updated."
        format.html { redirect_to dashboard_company_path }
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