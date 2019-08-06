class MembersController < ApplicationController
  load_and_authorize_resource :member, :class => 'User', :parent => false

  def new
    respond_to do |format|
      format.html
    end
  end

  def index
    respond_to do |format|
      format.html
    end
  end

  def create  
    if User.count_of_members_and_supervisors?(current_user, @member)
      password = Devise.friendly_token.first(8)
      @member.company = @current_company
      @member.password = @member.password_confirmation = @member.initial_password = password
      if @member.save
        redirect_to dashboard_company_path(@current_company)
      else
        render :new
      end
    else
      flash[:error] = "Exceeds from limit."
      redirect_to dashboard_company_path(@current_company)   
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    if @member.update_attributes(member_params)
      redirect_to members_path
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_path
  end

  private

  def member_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end