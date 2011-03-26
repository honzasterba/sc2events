# == Schema Information
# Schema version: 20110326112515
#
# Table name: authorizations
#
#  id         :integer(4)      not null, primary key
#  provider   :string(255)     not null
#  uid        :string(255)     not null
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Authorization < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'])
  end

end
