module ApplicationHelper
  def full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def sidebar_menu
    if current_user.admin?
      sidebar_menu = { Menu: ['#_','home'], Employees: ['#_','users'], Surveys: ['#_','book-open'], Groups: ['#_','user-plus'] }
    elsif current_user.supervisor?
      sidebar_menu = { Menu: ['#_','home'], Members: ['#_','users'], Surveys: ['#_','book-open'], Groups: ['#_','user-plus'] }      
    end
  end
end