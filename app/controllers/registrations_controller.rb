class RegistrationsController < Devise::RegistrationsController

   # temporary function for adding company to new user
  def create
  	super do
  		resource.company = Company.find(2)
  		resource.save
  	end
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
end