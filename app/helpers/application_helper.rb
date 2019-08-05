module ApplicationHelper

  def sidebar_menu
      sidebar_menu = { Home: { url: dashboard_company_path(current_user), icon: '#_' },
                       Employees: { url: members_path, icon: '#_' },
                       Surveys: { url: '#_', icon: '#_' },
                       Groups: { url: groups_path, icon: '#_' } }
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