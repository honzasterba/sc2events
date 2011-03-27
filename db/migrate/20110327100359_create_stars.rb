class CreateStars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.integer :user_id, :null => false
      t.integer :event_id, :null => false
      t.timestamps
    end
    add_index :stars, :user_id
    add_index :stars, :event_id
    add_index :stars, [:user_id, :event_id], :unique => true

    add_column :events, :stars_count, :integer, :default => 0
  end

  def self.down
    drop_table :stars
    remove_column :events, :stars_count
  end
end
