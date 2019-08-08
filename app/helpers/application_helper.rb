module ApplicationHelper

  def full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def sidebar_menu
      sidebar_menu = { Dashboard: { url: dashboard_company_path(current_user), icon: 'tachometer' },
                       Employees: { url: members_path, icon: 'vcard-o' },
                       Surveys: { url: display_surveys_company_path(current_user.company_id), icon: 'file-text-o' },
                       Groups: { url: groups_path, icon: 'group' } }
  end

  def get_current_user?
    current_user
  end

  def flash_type(key)
    if key == 'notice'
      'alert alert-success'
    elsif key == 'warning'
      'alert alert-warning'
    elsif key == 'error' || key == 'alert'
      'alert alert-danger'
    elsif key == 'notify'
      'alert alert-info'
    end
  end
end