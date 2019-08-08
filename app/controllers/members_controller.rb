class MembersController < ApplicationController
  load_and_authorize_resource :member, class: 'User', parent: false

  def new
    respond_to do |format|
      format.html
    end
  end

  def index
    respond_to do |format|
      format.html { @members = @members.reject { |user| user.id == current_user.id } }
      format.json { render json: @members }
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def create
    password = Devise.friendly_token.first(8)
    @member.company = @current_company
    @member.password = @member.password_confirmation = password
    respond_to do |format|
      if @member.save
        flash[:notice] = I18n.t 'users.member_create_success'
        format.html { redirect_to member_path(@member) }
      else
        flash[:error] = @member.errors.full_messages
        format.html { render :new }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @member.update_attributes(member_params)
        flash[:notice] = I18n.t 'users.member_update_success'
        format.html { redirect_to member_path(@member) }
      else
        flash[:error] = @member.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @member.destroy
      flash[:notice] = I18n.t 'users.member_destroy_success'
    else
      flash[:error] = @member.errors.full_messages
    end
    respond_to do |format|
      format.html { redirect_to members_path }
    end
  end

  private

  def member_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
