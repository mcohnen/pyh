class ReservablesController < ApplicationController
  
  def index
    #Reservable.create_cache

    @location = Location.find(1)
    @sport = Sport.find(2)
    @places = Reservable.find_in_days(Time.now, 1, @location, @sport)
    @times = @location.available_times Time.now, 3
  end
  
  def show
    
  end

end
