class UserSettingsController < ApplicationController
  load_and_authorize_resource
  before_action :breadcrumb_path_add
  #/user_settings/id/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @user_setting.update(user_setting_params)
        flash[:notice] = I18n.t 'user_settings.user_settings_update_success'
        format.html { redirect_to dashboard_company_path }
      else
        flash[:error] = @user_setting.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  private 
    def user_setting_params
      params.require(:user_setting).permit(:emails_subscription, :show_graphs, :show_history)
    end

    def breadcrumb_path_add
      add_breadcrumb "<b>My Settings</b>".html_safe, edit_user_setting_path
    end
end