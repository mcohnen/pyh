class Sport < ActiveRecord::Base
  has_many :items
  
  def eql?(other)
    other.id.eql?(self.id)
  end
  
  def hash
    self.id
  end
end
