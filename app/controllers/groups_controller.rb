class GroupsController < ApplicationController
  load_and_authorize_resource

  before_action only: [:new, :edit, :create, :update] do
    @employees = User.all
  end

  def new
  end

  def create
    respond_to do |format|
      @group.company = @current_company
      if @group.save!
        flash[:notice] = "Group created successfully!"
        format.html { redirect_to groups_path }
      else
        flash[:error] = "#{ @group.errors.messages.first[0] } #{ @group.errors.messages.first[1][0] }"
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
        flash[:error] = "#{ @group.errors.messages.first[0] } #{ @group.errors.messages.first[1][0] }"
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
