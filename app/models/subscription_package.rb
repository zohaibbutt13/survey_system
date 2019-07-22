class SubscriptionPackage < ActiveRecord::Base
  has_many :companies

  def self.get_packages
    @packages = Array[]
    SubscriptionPackage.find_each do |package|
      @packages.push(package)
    end
    # Update: Currently there are no packages in db
    # So remove the following hard cored array after adding data to db
    @packages = ['Platinum', 'Gold', 'Silver']
    @packages
  end
end
