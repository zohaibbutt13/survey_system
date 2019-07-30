module ApplicationHelper
  def full_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  def sidebar_menu
      sidebar_menu = { Menu: { url: '#_', icon: 'home' },
                       Employees: { url: '#_', icon: 'users' },
                       Surveys: { url: '#_', icon: 'book-open' },
                       Groups: { url: '#_', icon: 'user-plus' } }
  end

  def get_current_user?
    current_user
  end
end