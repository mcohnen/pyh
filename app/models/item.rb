class Item < ActiveRecord::Base
  belongs_to :place
  belongs_to :sport
  has_many :reservables
end
