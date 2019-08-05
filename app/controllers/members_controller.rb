class MembersController < ApplicationController
  load_and_authorize_resource :member, class: 'User', parent: false

  def new
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: @members}
    end
  end

  def create
    password = Devise.friendly_token.first(8)
    @member.company = @current_company
    @member.password = @member.password_confirmation = password
    if @member.save
      flash[:notice] = "Member created successfully!"
      redirect_to members_path
    else
      flash[:error] = "#{ @member.errors.messages.first[0] } #{ @member.errors.messages.first[1][0] }"
      render :new
    end
  end

  def edit
  end

  def update
    if @member.update_attributes(member_params)
      flash[:notice] = "Member updated successfully!"
      redirect_to members_path
    else
      flash[:error] = "#{ @member.errors.messages.first[0] } #{ @member.errors.messages.first[1][0] }"
      render :edit
    end
  end

  def destroy
    if @member.destroy
      flash[:notice] = "Member destroyed successfully!"
    else
      flash[:error] = "Error! Please try again."
    end
    redirect_to members_path
  end

  private

  def member_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
