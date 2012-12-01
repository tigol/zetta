# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# load test fixtures for rake db:seed LOAD_FIXTURES=true
if ENV['LOAD_FIXTURES']
  puts "loading test fixtures..."
  Fabricate(:dining)
  Fabricate(:billing)
  Fabricate(:nov_water_billing)
  Fabricate(:dec_water_billing)

  puts "loading fixtures completed."
end
