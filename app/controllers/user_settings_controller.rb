class UserSettingsController < ApplicationController
	
  before_action :authenticate_user! do
	  @user = current_user
  end

  #/user_settings/new
  def new
    @u_settings = UserSetting.new;
  end

  #def index
  #  @u_settings = UserSetting.find_by_user_id(@user.id);
  #end

  #/user_settings/id/edit
  def edit
    @u_settings = UserSetting.find_by_user_id(params[:id]);
  end

  #def show
   # @u_settings = UserSetting.find(params[:id]);
  #end

  def create
    #Need_Modify
    @u_settings = UserSetting.new(u_params);

    respond_to do |format|
      if @u_settings.save
        format.html { redirect_to @u_settings, notice: 'UserSetting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @u_settings = UserSetting.find(params[:id]);
    respond_to do |format|
      if @u_settings.update(u_params)
        format.html { redirect_to dashboard_path, notice: 'Settings was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private 
    def u_params
      params.require(:user_setting).permit(:emails_subscription, :show_graphs, :show_history, :company_id, :user_id)
    end
end