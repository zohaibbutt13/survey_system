class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action only: [:new, :edit, :create, :update] do
    @employees = User.all
  end

  def show
    @group_members = @group.users.map(&:full_name).join(', ')
    respond_to do |format|
      format.html
    end
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    @group.company = @current_company
    respond_to do |format|
      if @group.save
        flash[:notice] = I18n.t 'group_create_success'
        format.html { redirect_to @group }
      else
        flash[:error] = @group.errors.full_messages
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @group.update_attributes(group_params)
        flash[:notice] = I18n.t 'group_update_success'
        format.html { redirect_to @group }
      else
        flash[:error] = @group.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def index
    respond_to do |format|
      format.html
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = I18n.t 'group_destroy_success'
    else
      flash[:error] = @group.errors.full_messages
    end
    respond_to do |format|
      format.html { redirect_to groups_path }
    end
  end

  def group_params
    params.require(:group).permit(:name, :description, :user_ids => [])
  end
end
