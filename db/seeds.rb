# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# rake db:seed
users = User.all
users.each do |user|
  (1..100).each do |i|
    # puts Pin.order("RANDOM()").first.id
    user.upjoins.create(pin_id: Pin.order("RANDOM()").first.id)
    puts "new user pin"
  end
  newEntries = Upjoin.where(user_id: user.id)
  puts newEntries
end
