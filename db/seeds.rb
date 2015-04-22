# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

locations = Location.create([{title: "Georgia Theatre", description: "A large, newly re-built concert venue with a large indoor auditorium and a rooftop bar.", latitude: "78978967876", longitude: "7987896868"}, {title: "40 Watt Club", description: "A smaller live music venue with a long history and a charming dive-bar feel.", latitude: "78978546546", longitude: "675456587798"}, {title: "Hendershot's", description: "A coffee shop by day and bar at night featuring open mics and small live acts.", latitude: "7756545646", longitude: "4565675878"}])

activities = Activity.create([{title: "Black Keys Concert"}, {title: "Alabama Shakes Concert"}, {title: "Open Mic Night"}, {title: "Chief Keef Autograph Signing"}])