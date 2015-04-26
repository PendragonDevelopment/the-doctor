# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

#create an activity
activity = Activity.create(title: "Juggling Competition")

#create a location
location = Location.create(title: "Georgia Theater")

#create one user
u = User.create(first_name: "John", last_name: "Johnson", password: 'password1234', username: "johnjohnson")

#set that user as a host
u.host = Host.create

event = u.host.events.create(activity_id: activity.id, location_id: location.id, rate: 500)



