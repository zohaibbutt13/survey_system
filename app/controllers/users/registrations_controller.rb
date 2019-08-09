class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Sign up"
    super do
      resource.company = Company.new
    end
  end

  private

  def sign_up_params
    params[:user][:role] = User::ROLE[:admin]
    subscription_package = SubscriptionPackage.find_by_subscription_package_name('Trial')
    params[:user][:company_attributes][:subscription_package_id] = subscription_package.id
    params.require(:user).permit(:role, :first_name, :last_name, :email, :password, :password_confirmation,
                                 :image, company_attributes: [:name, :subdomain, :subscription_package_id])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end