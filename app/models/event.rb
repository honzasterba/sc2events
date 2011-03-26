# == Schema Information
# Schema version: 20110326112515
#
# Table name: events
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)     not null
#  starts_at  :date            not null
#  ends_at    :date
#  homepage   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base

  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :starts_at, :presence => true

end
