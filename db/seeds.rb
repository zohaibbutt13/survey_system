# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Company.create(name: '7vals')
Company.create(name: 'kfc')

activity_list = [
  [ 1, 2, 'created', 'survey', 10 ],
  [ 1, 2, 'edited', 'survey', 10 ],
  [ 1, 3, 'created', 'group', 5 ],
  [ 1, 3, 'created', 'survey', 11 ]
]

activity_list.each do |company_id, owner_id, action, trackable_type, trackable_id|
  Activity.create(company_id: company_id, owner_id: owner_id, action: action,
                  trackable_type: trackable_type, trackable_id: trackable_id)
end