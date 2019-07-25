class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action do
    @employees = User.accessible_by(current_ability)
  end

  def new
  end

  def create
    @group.company = @current_company

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update_attributes(group_params)
      redirect_to groups_path
    else
      render :edit
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
