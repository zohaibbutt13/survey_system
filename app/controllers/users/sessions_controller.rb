# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    add_breadcrumb "Home", root_path
    add_breadcrumb "Sign in"
    super
  end

  # POST /resource/sign_in
  def create
    super do
      if request.subdomain != resource.company.subdomain
        sign_out resource
        redirect_to root_url
        return
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
