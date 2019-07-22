class CompanySettingsController < ApplicationController

  #/company_settings/new
  def new
    @nc_settings = CompanySetting.new;
  end

  #def show
  #  @sc_settings = CompanySetting.find(params[:id]);        
  #end

  #/company_settings/id/edit
  def edit
    @ec_settings = CompanySetting.find_by_company_id(params[:id]);
  end

  #def index
  #end

  def create
    #Need_Modify
    @c_settings = CompanySetting.new(c_params);

    respond_to do |format|
      if @c_settings.save
        format.html { redirect_to @c_settings, notice: 'CompanySetting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @u_settings = CompanySetting.find(params[:id]);
    respond_to do |format|
      if @u_settings.update(c_params)
        format.html { redirect_to dashboard_path, notice: 'Settings was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end
  
  private 
    def c_params
      params.require(:company_setting).permit(:is_my_settings_sup, :is_my_settings_memb, :is_sup_create_surv, :is_sup_edit_surv, :max_questions, :survey_expiry, :company_id)
    end
end