class CompaniesController < ApplicationController  
  before_action :authenticate_user! do
  end
  
  def dashboard
  end

  def subscription_packages
    @subscription_packages = SubscriptionPackage.first(3)
  end

  def update_subscription_package
    current_user.company.subscription_package_id = params[:id]
    current_user.company.save
    respond_to do |format|
      flash[:notice] = "Subscription Package is successfully updated."  
      format.html { redirect_to dashboard_company_path }
    end
  end
end