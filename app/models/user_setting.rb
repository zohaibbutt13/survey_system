class UserSetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  def self.create_user_settings?(user_settings_object)
    user_settings_object.save
  end

  def self.update_user_settings?(user_settings_object, user_settings_params)
    user_settings_object.update(user_settings_params)
  end

end
