class UserSetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  def create_user_setting?
    save
  end

  def update_user_setting?(user_setting_params)
    update(user_setting_params)
  end
end