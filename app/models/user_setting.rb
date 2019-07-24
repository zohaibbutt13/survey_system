class UserSetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  def self.create_user_setting?(user_setting_object)
    user_setting_object.save
  end

  def self.update_user_setting?(user_setting_object, user_setting_params)
    user_setting_object.update(user_setting_params)
  end

end
