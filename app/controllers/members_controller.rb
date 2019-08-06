class MembersController < ApplicationController
  load_and_authorize_resource :member, :class => 'User', :parent => false

  def new
  end

  def index
  end

  def create
    current_supervisors_count = User.where(role: User::ROLE[:supervisor]).count
    current_memebers_count = User.where(role: User::ROLE[:member]).count
    max_supervisors = current_user.company.subscription_package.max_supervisors
    max_members = current_user.company.subscription_package.max_members   
    if (@member.supervisor? && current_supervisors_count < max_supervisors) || (@member.member? && current_memebers_count < max_members)
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