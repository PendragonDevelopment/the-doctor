# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

#create one user
u = User.create(first_name: "John", last_name: "Johnson", password: "password1234", password_confirmation: "password1234", username: "johnjohnson", email: "user@email.com")
u_rater = User.create(first_name: "Lara", last_name: "Tyler", password: "thousandfeathers", password_confirmation: "thousandfeathers", username: "ornithologist", email: "lara@email.com")

#set that user as a host
u.host = Host.create

#create an activity
activity = Activity.create(title: "Juggling Competition")

#create a location
location = Location.create(title: "Georgia Theater")
juggling = Activity.create(title: "Juggling Competition")
mouserat = Activity.create(title: "Mouserat Show")
ratmouse = Activity.create(title: "Ratmouse Show")

#create a location
gatheater = Location.create(title: "Georgia Theater")
nucis = Location.create(title: "Nuci's Space")
fortywatt = Location.create(title: "40 Watt")


event = u.host.events.create(activity_id: activity.id, location_id: location.id, event_rate: 500)

u.host.events.create(activity_id: juggling.id, location_id: gatheater.id, event_rate: 3000)
u.host.events.create(activity_id: mouserat.id, location_id: gatheater.id, event_rate: 5000)
u.host.events.create(activity_id: mouserat.id, location_id: nucis.id, event_rate: 4000)
u.host.events.create(activity_id: ratmouse.id, location_id: nucis.id, event_rate: 500)
u.host.events.create(activity_id: ratmouse.id, location_id: fortywatt.id, event_rate: 4000)
u.host.events.create(activity_id: juggling.id, location_id: fortywatt.id, event_rate: 6000)
u.host.events.create(activity_id: mouserat.id, location_id: fortywatt.id, event_rate: 1000)
u.host.events.create(activity_id: mouserat.id, location_id: fortywatt.id, event_rate: 1000)


