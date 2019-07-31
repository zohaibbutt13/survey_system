class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action only: [:new, :edit, :create, :update] do
    @employees = User.accessible_by(current_ability)
  end

  def new
  end

  def create
    respond_to do |format|
      if @group.create_group(@current_company.id)
        flash[:notice] = "Group created successfully!"
        format.html { redirect_to groups_path }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @group.update_group(group_params)
        flash[:notice] = "Group updated successfully!"
        format.html { redirect_to groups_path }
      else
        format.html { render :edit }
      end
    end
  end

  def index
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def group_params
    params.require(:group).permit(:name, :description, :user_ids => [])
  end
end
