class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      # format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      # format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  rescue_from ActionController::RoutingError do |exception|
    render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
  end

  before_action do
    # binding.pry
    unless request.subdomain.empty?
      @current_company = Company.find_by_subdomain(request.subdomain)

      if @current_company == nil
        page_not_found
      end
    end

    if @current_company.present? && user_signed_in?
      @company_setting, @user_setting = @current_company.dashboard_resources(current_user)
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_company_path(current_user.company)
  end
 
  def authenticate_admin!
    unless current_user.admin?
      redirect_to dashboard_company_path(current_user.company)
    end
  end

  def page_not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def get_subdomain
    request.subdomain
  end
  helper_method :get_subdomain

end