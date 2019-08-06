class CompaniesController < ApplicationController  
  before_action :authenticate_user! do
    @current_company = current_user.company
  end
  add_breadcrumb "Home", :dashboard_company_path
  
  def dashboard
  end

  def subscription_packages
    add_breadcrumb "Subscription Packages", :subscription_packages_company_path
    @subscription_packages = SubscriptionPackage.all
  end

  def update_subscription_package
    @current_subscription_package = SubscriptionPackage.find(params[:id])
    @current_company.subscription_package_id = @current_subscription_package.id
    @current_company.save!
    respond_to do |format|
      flash[:notice] = "Subscription Package is successfully updated."  
      format.html { redirect_to dashboard_company_path }
    end
  end
end
