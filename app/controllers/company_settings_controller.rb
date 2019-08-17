class CompanySettingsController < ApplicationController
  load_and_authorize_resource
  before_action :breadcrumb_path_add
  #/company_settings/id/edit
  def edit
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

    def breadcrumb_path_add
      add_breadcrumb "<b>Company Settings</b>".html_safe, edit_company_setting_path
    end
end