task add_packages: :environment do
  SubscriptionPackage.create(package_name: 'Platinum Package', max_supervisors: 100, max_members: 1000)
  SubscriptionPackage.create(package_name: 'Gold Package', max_supervisors: 50, max_members: 500)
  SubscriptionPackage.create(package_name: 'Silver Package', max_supervisors: 20, max_members: 200)
  puts 'Packages added'
end