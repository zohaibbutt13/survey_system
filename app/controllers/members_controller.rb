class MembersController < ApplicationController
  load_and_authorize_resource :member, :class => 'User', :parent => false

  def new
  end

  def index
  end

  def create
    password = Devise.friendly_token.first(8)
    @member.company = @current_company
    @member.password = @member.password_confirmation = password
    if @member.save
      redirect_to dashboard_company_path(@current_company)
    else
      render :new
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
