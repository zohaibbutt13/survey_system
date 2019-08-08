class CompanySettingsController < ApplicationController
  load_and_authorize_resource

  #/company_settings/id/edit
  def edit
    add_breadcrumb "Company Settings", edit_company_setting_path
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @company_setting.update(company_setting_params)
        flash[:notice] = I18n.t 'company_settings.company_settings_update_success'
        format.html { redirect_to dashboard_company_path }
      else
        flash[:error] = @company_setting.errors.full_messages
        format.html { render :edit }
      end
    end
  end
  
  private 
    def company_setting_params
      params.require(:company_setting).permit(:supervisors_survey_permission, :supervisors_settings_permission, :members_settings_permission, :max_questions, :survey_expiry_days)
    end
end