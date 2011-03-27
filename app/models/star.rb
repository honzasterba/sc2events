# == Schema Information
# Schema version: 20110327100359
#
# Table name: stars
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  event_id   :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Star < ActiveRecord::Base

  belongs_to :user
  belongs_to :event, :counter_cache => 'stars_count'

  validates_presence_of :user_id, :event_id
  validates_uniqueness_of :event_id, :scope => :user_id

end
