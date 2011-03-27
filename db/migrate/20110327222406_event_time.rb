class EventTime < ActiveRecord::Migration
  def self.up
    change_column :events, :starts_at, :datetime
    change_column :events, :ends_at, :datetime
  end

  def self.down
    change_column :events, :starts_at, :date
    change_column :events, :ends_at, :date
  end
end
