module ApplicationHelper
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
