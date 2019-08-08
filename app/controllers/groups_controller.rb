class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action only: [:new, :edit, :create, :update] do
    @employees = User.all
  end

  def show
    add_breadcrumb "Group", group_path
    @group_members = @group.users.map(&:full_name).join(', ')
    respond_to do |format|
      format.html
    end
  end

  def new
    add_breadcrumb "Groups", groups_path
    add_breadcrumb "New Group", new_group_path
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      @group.company = @current_company
      if @group.save
        flash[:notice] = "Group created successfully!"
        format.html { redirect_to @group }
      else
        flash[:error] = @group.errors.full_messages
        format.html { render :new }
      end
    end
  end

  def edit
    add_breadcrumb "Groups", groups_path 
    add_breadcrumb "Update Group", edit_group_path 
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @group.update_attributes(group_params)
        flash[:notice] = "Group updated successfully!"
        format.html { redirect_to @group }
      else
        flash[:error] = @group.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def index
    add_breadcrumb "Groups", groups_path
    respond_to do |format|
      format.html
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def group_params
    params.require(:group).permit(:name, :description, :user_ids => [])
  end
end
