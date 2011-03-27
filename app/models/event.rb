# == Schema Information
# Schema version: 20110327100359
#
# Table name: events
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)     not null
#  starts_at   :date            not null
#  ends_at     :date
#  homepage    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  stars_count :integer(4)      default(0)
#

class Event < ActiveRecord::Base

  validates :name, :presence => true, :length => { :minimum => 3 }
  validates :starts_at, :presence => true
  validate :validate_finished_at

  has_many :stars, :dependent => :destroy

  scope :current, where("ends_at is NULL OR ends_at >= ?", Date.today).order('starts_at ASC')

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
    if upcoming?
      return 0
    elsif finished?
      return days_total
    elsif ends_at
      last = Date.today > ends_at.to_date ? ends_at.to_date : Date.today
    else
      last = Date.today
    end
    return (last - starts_at.to_date).to_i
  end
  
  def days_total
    if ends_at
      return (ends_at.to_date - starts_at.to_date).to_i + 1
    else
      return 1
    end
  end

  private

    def validate_finished_at
      if ends_at && starts_at && ends_at <= starts_at
        errors.add(:ends_at, "has to be after the starting date")
      end
    end

end
