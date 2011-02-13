class Location < ActiveRecord::Base
  has_many :places
  
  def sports
    Sport.joins(:items => [:place]).where(:places => {:location_id => self.id})
  end
  
  def available_times(start, days_ahead)
    time = start.change(:hour=>0)
    ret = {}
    until (time.day != start.day) do
      ret[time] = []
      (0..days_ahead).each do |i|
        ret[time] << time + i.days
      end
      time += 15.minutes
    end
    ret
  end
  
  def eql?(other)
    other.id.eql?(self.id)
  end
  
  def hash
    self.id
  end
      
end
