class SubscriptionPackage < ActiveRecord::Base
  has_many :companies

  def self.get_packages
    SubscriptionPackage.all
  end
end
