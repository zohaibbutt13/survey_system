class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action only: [:new, :edit, :create, :update] do
    @employees = User.all
  end

  def new
  end

  def create
    @group.company = @current_company
    respond_to do |format|
      if @group.save
        flash[:notice] = "Group created successfully!"
        format.html { redirect_to groups_path }
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
        flash[:notice] = "Group updated successfully!"
        format.html { redirect_to groups_path }
      else
        flash[:error] = @group.errors.full_messages
        format.html { render :edit }
      end
    end
  end

  def index
  end

  def destroy
    if @group.destroy
      flash[:notice] = "Group destroyed successfully!"
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
