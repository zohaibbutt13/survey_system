class UserSettingsController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb "My Settings", :edit_user_setting_path
  #/user_settings/id/edit
  def edit
    add_breadcrumb "edit", :edit_user_setting_path
  end

  def update
    respond_to do |format|
      if @user_setting.update(user_setting_params)
        flash[:notice] = "User settings was successfully updated."
        format.html { redirect_to dashboard_company_path }
      else
        format.html { render :edit }
      end
    end
  end

  private 
    def user_setting_params
      params.require(:user_setting).permit(:emails_subscription, :show_graphs, :show_history)
    end
end