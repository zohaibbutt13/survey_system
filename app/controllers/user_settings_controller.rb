class UserSettingsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user! do
    @user = current_user
  end

  #/user_settings/new
  def new
  end

  #/user_settings/id/edit
  def edit
  end

  def create
    #Need_Modification
    @user_setting = UserSetting.new(user_setting_params)

    respond_to do |format|
      if UserSetting.create_user_setting?(@user_setting)
        format.html { redirect_to @user_setting, notice: 'User Settings was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if UserSetting.update_user_setting?(@user_setting, user_setting_params)
        format.html { redirect_to dashboard_path, notice: 'User Settings was successfully updated.' }
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