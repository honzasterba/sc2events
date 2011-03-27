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
  validate :validate_finished_at

  def upcoming?
    starts_at && (starts_at > Date.today)
  end

  def in_progress?
    !finished? && starts_at && (starts_at < Date.today)
  end

  def finished?
    ends_at && (ends_at < Date.today)
  end

  def incomplete?
    ends_at.blank?
  end
  
  def days_passed
    return (Date.today - starts_at).to_i
  end
  
  def days_total
    return (ends_at - starts_at).to_i + 1
  end

  private

    def validate_finished_at
      if ends_at && starts_at && ends_at <= starts_at
        errors.add(:ends_at, "has to be after the starting date")
      end
    end

end
