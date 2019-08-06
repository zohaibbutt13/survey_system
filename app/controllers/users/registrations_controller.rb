class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_up
  def new
    super do
      resource.company = Company.new
    end
  end

  private

  def sign_up_params
    params[:user][:role] = User::ROLE[:admin]
    params.require(:user).permit(:role, :first_name, :last_name, :email, :password, :password_confirmation,
                                 :image, company_attributes: [:name, :subdomain])
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end
