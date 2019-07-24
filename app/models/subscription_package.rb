class SubscriptionPackage < ActiveRecord::Base
  has_many :companies

  def self.get_packages
    packages = SubscriptionPackage.all
    # Currently there are no packages in db
    # So packages can be blank therefore provided default packages
    if packages.blank?
      packages = [{ package_name: 'Platinum', max_supervisors: 50, max_members: 500 },
                  { package_name: 'Gold', max_supervisors: 20, max_members: 200 },
                  { package_name: 'Silver', max_supervisors: 10, max_members: 100 }]
    end
    packages
  end
end