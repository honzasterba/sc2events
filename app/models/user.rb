# == Schema Information
# Schema version: 20110326112515
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  admin      :boolean(1)
#

class User < ActiveRecord::Base

  has_many :authorizations

  def self.create_from_hash!(hash)
    create(:name => hash['user_info']['name'])
  end

end
