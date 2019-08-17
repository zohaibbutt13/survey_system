class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action :breadcrumb_path_add
  before_action only: [:new, :edit, :create, :update] do
    @employees = User.all
  end

  def show
    add_breadcrumb "<a>Group</a>".html_safe, group_path
    @group_members = @group.users.map(&:full_name).join(', ')
    respond_to do |format|
      format.html
    end
  end

  def new
    add_breadcrumb "<a>New Group</a>".html_safe, new_group_path
    respond_to do |format|
      format.html
    end
  end

  def create
    @group.company = @current_company
    @group.created_by_id = @current_user.id
    respond_to do |format|
      if @group.save
        flash[:notice] = I18n.t 'groups.group_create_success'
        format.html { redirect_to @group }
      else
        flash[:error] = @group.errors.full_messages
        format.html { render :new }
      end
    end
  end

  def edit
    add_breadcrumb "<a>Update Group</a>".html_safe, edit_group_path 
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @group.update_attributes(group_params)
        flash[:notice] = I18n.t 'groups.group_update_success'
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
      flash[:notice] = I18n.t 'groups.group_destroy_success'
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

  def breadcrumb_path_add
    add_breadcrumb "<b>Groups</b>".html_safe, groups_path
  end
end