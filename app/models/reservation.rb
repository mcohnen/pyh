class Reservation < ActiveRecord::Base
  belongs_to :reservable
  belongs_to :user
end
