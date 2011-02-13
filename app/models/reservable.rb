class Reservable < ActiveRecord::Base
  belongs_to :item
  has_many :reservations
  
  def self.find_for_time(rvs, time)
    rvs.find_all {|r| r.occurs_at?(time)}
  end
  
  def self.find_in_days(from, days, location, sport)
    cache = Rails.cache.read("cache")
    cache = self.create_cache if !cache
    ret = {}
    cache[location][sport].each { |t,v| ret[t] = v if t > from}
    ret
  end
  
  def self.create_cache
    #Rails.cache.delete("cache")
    now = Time.now.localtime.change(:hour => 0)
    cache = {}
    location = Location.find(1)
    sport = Sport.find(2)
    rvs = Reservable.joins(:item => [:place]).where(:places => {:location_id => location.id}, :items => {:sport_id => sport.id})
    (0..6).each do |i|
      start = now + i.days
      time = start
      until time.day !=  start.day do
        find_for_time(rvs, time).each do |r|
          item = r.item
          place = item.place
          cache[location] = {} if !cache[location]
          cache[location][sport] = {} if !cache[location][sport]
          cache[location][sport][time] = {} if !cache[location][sport][time]
          cache[location][sport][time][place] = {} if !cache[location][sport][time][place]
          cache[location][sport][time][place][item] = [] if !cache[location][sport][time][place][item]
          cache[location][sport][time][place][item] << r
        end
        time += 15.minutes
      end
    end
    cache.delete_if { |key,value| value.empty?}
    Rails.cache.write("cache", cache)
    cache
  end
  
  def rfc_rule
    IceCube::Rule.from_yaml(rfc)
  end
  
  def occurs_at?(time)
    start = Time.new(time.year, time.month, time.day, 0, 0, 0, time.utc_offset)
    schedule = IceCube::Schedule.new(start)
    schedule.add_recurrence_rule(rfc_rule)
    schedule.occurs_at?(time)
  end
  
end
