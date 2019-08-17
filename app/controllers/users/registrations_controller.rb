class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    super do
      resource.company = Company.new
    end
  end

  def edit
    add_breadcrumb "<a>Your Account</a>".html_safe, edit_user_registration_path
    super
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