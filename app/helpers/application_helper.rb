module ApplicationHelper

  def full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def sidebar_menu
      sidebar_menu = { Menu: { url: dashboard_company_path(current_user), icon: 'home' },
                       Employees: { url: members_path, icon: 'users' },
                       Surveys: { url: display_surveys_company_path, icon: 'book-open' },
                       Groups: { url: groups_path, icon: 'user-plus' } }
  end

  def get_current_user?
    current_user
  end

  def flash_type(key)
    if key == 'notice'
      'alert alert-success'
    elsif key == 'warning'
      'alert alert-warning'
    elsif key == 'error'
      'alert alert-danger'
    elsif key == 'notify'
      'alert alert-info'
    end
  end
end