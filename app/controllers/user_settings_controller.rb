class UserSettingsController < ApplicationController
	
  before_action :authenticate_user! do
	  @user = current_user
  end

  #/user_settings/new
  def new
    @user_settings = UserSetting.new
  end

  #/user_settings/id/edit
  def edit
    @user_settings = UserSetting.find_by_user_id(params[:id])
  end

  def create
    #Need_Modification
    @user_settings = UserSetting.new(user_settings_params)

    respond_to do |format|
      if UserSetting.create_user_settings?(@user_settings)
        format.html { redirect_to @user_settings, notice: 'User Settings was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @user_settings = UserSetting.find(params[:id])
    respond_to do |format|
      if UserSetting.update_user_settings?(@user_settings, user_settings_params)
        format.html { redirect_to dashboard_path, notice: 'User Settings was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private 
    def user_settings_params
      #company_id and user_id areadded temporary... Will be removed
      params.require(:user_setting).permit(:emails_subscription, :show_graphs, :show_history, :company_id, :user_id)
    end
end