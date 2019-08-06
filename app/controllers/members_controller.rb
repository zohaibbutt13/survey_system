class MembersController < ApplicationController
  load_and_authorize_resource :member, :class => 'User', :parent => false

  def new
    add_breadcrumb "Employees", members_path
    add_breadcrumb "New Employee"
  end

  def index
    add_breadcrumb "Employees"
  end

  def create
    password = Devise.friendly_token.first(8)
    @member.company = @current_company
    @member.password = @member.password_confirmation = @member.initial_password = password
    if @member.save
      redirect_to dashboard_company_path(@current_company)
    else
      render :new
    end
  end

  def edit
    add_breadcrumb "Employees", members_path
    add_breadcrumb "Update Employee"
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
