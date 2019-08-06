class UserSettingsController < ApplicationController
  load_and_authorize_resource
  #/user_settings/new
  def new
  end

  #/user_settings/id/edit
  def edit
  end

  def create
    respond_to do |format|
      if @user_setting.save
        flash[:notice] = "User settings was successfully created."
        format.html { redirect_to @user_setting }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_setting.update(user_setting_params)
        flash[:notice] = "User ettings was successfully updated."
        format.html { redirect_to dashboard_company_path }
      else
        format.html { render :edit }
      end
    end
  end

  private 
    def user_setting_params
      #Company_id and user_id is removed
      params.require(:user_setting).permit(:emails_subscription, :show_graphs, :show_history)
    end
end