# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

tennis = Sport.create :name => "Tennis"
padel = Sport.create :name => "Padel"

madrid = Location.create :name => "Madrid"
dublin = Location.create :name => "Dublin"

place_chamartin = Place.create :name => "Chamartin", :permalink => "chamartin"
place_ccampo = Place.create :name => "Club de Campo", :permalink => "clubdecampo"

padel1 = Item.create :name => 'Padel 1', :sport => padel
padel2 = Item.create :name => 'Padel 2', :sport => padel

morning_hourly = IceCube::Rule.hourly().hour_of_day(*(9..12)).to_yaml
afternoon_hourly = IceCube::Rule.hourly().hour_of_day(*(13..17)).to_yaml
evening_hourly = IceCube::Rule.hourly().hour_of_day(*(18..21)).to_yaml

rv1 = {:label => "morning", :minutes => 60, :price => 10, :rfc => morning_hourly}
rv2 = {:label => "afternoon", :minutes => 60, :price => 12, :rfc => afternoon_hourly}
rv3 = {:label => "evening", :minutes => 60, :price => 14, :rfc => evening_hourly}

padel1.reservables << [Reservable.new(rv1), Reservable.new(rv2), Reservable.new(rv3)]
padel2.reservables << [Reservable.new(rv1), Reservable.new(rv3)]

place_chamartin.items << [padel1, padel2]
madrid.places << [place_chamartin, place_ccampo]





