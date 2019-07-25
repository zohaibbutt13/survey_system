class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      # format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      # format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  before_action :authenticate_user! do
    @current_company ||= current_user.company if user_signed_in?
  end

  def after_sign_in_path_for(resource)
    dashboard_company_path(current_user.company)
  end
 
  def authenticate_admin!
    unless current_user.admin?
      redirect_to dashboard_company_path(current_user.company)
    end
  end

  def get_subdomain
    request.subdomain
  end
  helper_method :get_subdomain
end
