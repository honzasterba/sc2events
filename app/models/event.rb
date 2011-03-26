class Event < ActiveRecord::Base

  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :starts_at, :presence => true

end
